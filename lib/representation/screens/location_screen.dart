

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';
import 'package:vrb_client/provider/location_provider.dart';
import 'package:vrb_client/representation/screens/search_location_screen.dart';
import 'package:vrb_client/representation/widgets/custom_button_sheet_widger.dart';

import '../../core/constants/assets_path.dart';
import '../../core/constants/dimension_constants.dart';
import '../../models/bank_location.dart';
import '../../models/distance_point.dart';
import '../../models/district.dart';
import '../../models/province.dart';
import '../../network/netword_request.dart';
import '../../provider/dialog_provider.dart';
import '../widgets/address_form_widget.dart';
import '../widgets/app_bar_continer_widget.dart';
import '../widgets/select_local_widget.dart';
import 'loading_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});
  static String routeName = '/location_screen';
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GlobalKey<ExpandableBottomSheetCustomState> key = GlobalKey();
  GoogleMapController? mapController;
  Completer<GoogleMapController> _controller = Completer();
  String provinceName = LocaleKeys.province.tr();
  String districtName = LocaleKeys.district.tr();

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).fetchData();
    Provider.of<LocationProvider>(context, listen: false).getLocationUpdate();
    Provider.of<LocationProvider>(context, listen: false).createCustomMarker();
    _requestPermission();
  }


  //TODO test truong hop user khong cho phep truy cap local
  Future<void> _requestPermission() async {
    final hasPermission = await Provider.of<LocationProvider>(context, listen: false).locationController.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      // Hiển thị hướng dẫn hoặc thông báo
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Quyền truy cập bị từ chối"),
            content: Text("Ứng dụng cần quyền truy cập để hiển thị bản đồ."),
            actions: <Widget>[
              FloatingActionButton  (
                child: Text("Đóng"),
                onPressed: () {
                  // chuyen huong nguoi
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildButton(String title, VoidCallback onPressed, int index){

    return GestureDetector(
      onTap: () {
        Provider.of<LocationProvider>(context, listen: false).setSelectedButtonIndex(index);
        onPressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300), // Thời gian chuyển đổi
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: index == Provider.of<LocationProvider>(context, listen: false).selectedButtonIndex ? Colors.grey.withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: index == 0 ? Radius.circular(20) : Radius.zero,
            topRight: index == 2 ? Radius.circular(20) : Radius.zero,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 12, color: index == Provider.of<LocationProvider>(context, listen: false).selectedButtonIndex ? Colors.white : Colors.white60),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildButtonLocal(String name, Function() onTap){
    return  Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Điều chỉnh vị trí của bóng
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(name,
                  style: TextStyle(fontSize: 18, fontWeight:
                  FontWeight.bold),
                )),
            Image.asset(AssetPath.icoDownBold),
          ],
        ),
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ScrollController scrollController = ScrollController();
    int isCheckChoose = 0;

    double distanceBetween(String latitude, String longitude){
      return Geolocator.distanceBetween
        (Provider.of<LocationProvider>(context, listen: false).currentLocation.latitude, Provider.of<LocationProvider>(context, listen: false).currentLocation.longitude, double.parse(latitude), double.parse(longitude));
    }

    List<Map<String, BankLocation>> sortMap(List<Map<String, BankLocation>> newAddresses)  {
      for(int i = 0; i < newAddresses.length; i++){
        List<MapEntry<String, BankLocation>> entries = newAddresses[i].entries.toList();
        entries.sort((a, b) => distanceBetween(a.value.latitude, a.value.longitude).compareTo(distanceBetween(b.value.latitude, b.value.longitude)));
        Map<String, BankLocation> sortedMap = Map.fromEntries(entries);
        newAddresses[i] = sortedMap;
      }
      return newAddresses;
    }

    return Consumer<LocationProvider>(builder: (context, location,  child){
      return Scaffold(
        appBar:  AppBarContainerWidget(title: LocaleKeys.locationTitle.tr()),
        body: location.isLoading == true ? LoadingScreen() : ExpandableBottomSheetCustom(
          key: key,
          // onIsContractedCallback: () => print('contracted'),
          // onIsExtendedCallback: () => print('extended'),
          // animationDurationExtend: Duration(milliseconds: 500),
          // animationDurationContract: Duration(milliseconds: 250),
          // animationCurveExpand: Curves.bounceOut,
          // animationCurveContract: Curves.ease,
          // persistentContentHeight: 0, // do rong khi keo xuong

          background: Stack(
            children: [
              Positioned.fill(
                  child: GoogleMap(
                    zoomControlsEnabled: false, // tat ban do
                    mapType: MapType.normal,
                    initialCameraPosition: const CameraPosition(
                      // target: LatLng(21.005536, 105.8180681),
                      target: LatLng(21.005536, 105.8180681),
                      zoom: 10,
                    ),
                    polylines: location.polylines,
                    markers: location.markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      setState(() {
                        mapController = controller;
                      });
                    },
                  )
              ),

              Positioned(
                top: kMinPadding,
                left: kMinPadding,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: size.width -
                      (2 *
                          kMinPadding), // Sử dụng chiều rộng của màn hình trừ đi khoảng cách mép trái và phải
                  child: _buildButtonLocal(

                      provinceName , (){
                    List<String> data = Provider.of<LocationProvider>(context, listen: false).locations
                        .entries.map((e){
                      return e.value.regionName;
                    }).toList();
                    Navigator.of(context).pushNamed(SearchLocationScreen.routeName,
                      arguments: {'searchTerms': data, 'titleField': LocaleKeys.province.tr()}, ).then((value) async {
                      print(value);
                      Map<String, District> newDistricts = await DioTest.postDistrict(location.locations[value]?.regionCode1 ?? "Hà Nội");
                      List<Map<String, BankLocation>>  newAddresses = await DioTest.postBranchATMTypeTwo
                        (location.currentLocation.longitude.toString(), location.currentLocation.latitude.toString(),location.locations[value]?.regionCode1 ?? "Hà Nội");
                      location.clearPolylines();
                      //TODO fix provider
                      location.setProvinceChose(value.toString());
                      location.setDistricts(newDistricts);
                      location.setAddress(newAddresses);
                      location.setMarker(location.setMarkers(0));
                      setState(() {
                        provinceName = value.toString();
                        districtName = LocaleKeys.district.tr();
                      });
                      Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
                      await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
                      Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
                    });

                  }),
                ),
              ),
              Positioned(
                top: kDefaultPadding * 2 +
                    40, // Đặt vị trí của SelectLocalWidget tiếp theo
                left: kMinPadding,
                width: size.width -
                    (2 * kMinPadding),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: size.width -
                      (2 *
                          kMinPadding),
                  child: _buildButtonLocal(districtName, (){
                    List<String> data = Provider.of<LocationProvider>(context, listen: false).districts
                        .entries.map((e){
                      return e.value.districtName;
                    }).toList();
                    print(location);
                    Navigator.of(context).pushNamed(SearchLocationScreen.routeName,
                        arguments: {'searchTerms': data, 'titleField': LocaleKeys.district.tr()}).then((value) async {
                      print(value);

                      List<Map<String, BankLocation>> newAddresses = await DioTest.postBranchATMTypeThree
                        (location.currentLocation.longitude.toString(), location.currentLocation.latitude.toString(),
                          location.locations[location.provinceChose]?.regionCode1 ?? "101", location.districts[value]?.districtCode ?? "10111");
                      location.setDistrictChose(value.toString());
                      location.setMarkers(1);
                      location.setAddress(newAddresses);
                      location.setMarker(location.setMarkers(location.index));
                      setState(() {
                        districtName = value.toString();
                      });
                      Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
                      await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
                      Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
                    });

                    // showSearch(context: context, delegate: SearchLocationWidget(
                    //     searchTerms:data, onSelect: (String value) async {
                    //       print(value);
                    //
                    //       List<Map<String, BankLocation>> newAddresses = await DioTest.postBranchATMTypeThree
                    //         (location.currentLocation.longitude.toString(), location.currentLocation.latitude.toString(),
                    //           location.locations[location.provinceChose]?.regionCode1 ?? "101", location.districts[value]?.districtCode ?? "10111");
                    //         location.setDistrictChose(value);
                    //         location.setMarkers(1);
                    //         location.setAddress(newAddresses);
                    //         location.setMarker(location.setMarkers(location.index));
                    //         setState(() {
                    //           districtName = value;
                    //         });
                    //       // Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
                    //       // await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
                    //       // Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
                    // }
                    // ));
                  }),
                ),
              ),
            ],
          ),

          persistentHeader: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white60,
                    mini: true,
                    foregroundColor: Colors.black,
                    elevation: 4,
                    onPressed: () {
                      if (mapController != null) {
                        mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(21.005536, 105.8180681)));
                      }
                    },
                    child: const Icon(FontAwesomeIcons.locationArrow),
                  ),
                ),
              ),
              Container(
                // margin: EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF19226D),
                        Color(0xFFED1C24),
                      ],
                      stops: [0.5, 1],
                    )),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Expanded(child: _buildButton(LocaleKeys.nearest.tr(), () async{
                          //TODO tam thoi fix call
                          try{
                            List<Map<String, BankLocation>> newAddresses = await DioTest.
                            postBranchATMTypeOne(location.currentLocation.longitude.toString(), location.currentLocation.latitude.toString());
                            location.customMarker;
                            location.setMarkers(0);
                            //TODO sua trong provider
                            location.setAddress(sortMap(newAddresses));
                            location.setMarker(location.setMarkers(0)); // Cập nhật lại markers khi danh sách address được cập nhật
                          }catch(e){
                            location.setMarkers(0);
                            print("Loi duoc goi $e");
                          }
                        }, 0)),
                        Expanded(child: _buildButton('ATM', () async {
                          if(location.provinceChose != null){
                            String regionCode1 = location.locations[location.provinceChose]?.regionCode1 ?? "101";
                            List<Map<String, BankLocation>>  newAddresses = await DioTest.
                            postBranchATMTypeTwo(location.currentLocation.longitude.toString(), location.currentLocation.latitude.toString(),regionCode1);
                            location.customMarker;
                            location.setMarkers(0);
                            // TODO
                            location.setAddress(sortMap(newAddresses));
                            location.setMarker(location.setMarkers(location.index));// Cập nhật lại markers khi danh sách address được cập nhật
                          }else{
                            location.setIndex(0);
                            location.setMarker(location.setMarkers(location.index));
                          }

                        }, 1)),
                        Expanded(child: _buildButton(LocaleKeys.branch.tr(), () async {
                          if(location.districtChose != null){
                            String regionCode1 = location.locations[location.provinceChose]?.regionCode1 ?? "101";
                            String districtCode = location.districts[location.districtChose]?.districtCode ?? '10111';
                            List<Map<String, BankLocation>> newAddresses =
                            await DioTest.postBranchATMTypeThree(location.currentLocation.longitude.toString(), location.currentLocation.latitude.toString(),
                                regionCode1, districtCode) ;
                            location.customMarker;
                            location.setIndex(0);
                            //todo
                            location.setAddress(sortMap(newAddresses));
                            location.setMarker(location.setMarkers(location.index));
                          }else{
                            location.setIndex(0);
                            location.setMarker(location.setMarkers(location.index)); // Cập nhật lại markers khi danh sách address được cập nhật
                          }

                        }, 2)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          expandableContent: Container(
              constraints: const BoxConstraints.expand(height: 400), // do rong khi keo len
              decoration: const BoxDecoration(
                color: Colors.white,),
              child: ListView(
                controller: scrollController,
                children:  (Provider.of<LocationProvider>(context, listen: false).address[location.index].isNotEmpty) ?
                Provider.of<LocationProvider>(context, listen: false).address[(location.index != 0 || location.index != 1) ? location.index : 0].entries.map((e) {
                  return GestureDetector(
                    onTap: () {
                      //TODO dang lay gt default
                      //     _createPolylines(LatLng(21.005536, 105.8180681), LatLng(double.parse(e.value.latitude), double.parse(e.value.longitude)));
                      // _createPolylines(_currentLocation, LatLng(double.parse(e.value.latitude), double.parse(e.value.longitude)));
                      location.createPolylines(location.currentLocation, LatLng(double.parse(e.value.latitude), double.parse(e.value.longitude)));
                    },
                    child: AddressFormWidget(
                      icon: (e.value.idImage == 'atm00') ? AssetPath.icoChiNhanhSo : AssetPath.icoSo,
                      title: e.value.shotName,
                      description: e.key.toString(),
                      distance: Geolocator.distanceBetween(location.currentLocation.latitude, location.currentLocation.longitude, double.parse(e.value.latitude), double.parse(e.value.longitude)),
                      distancePoint: DistancePoint(location.currentLocation.latitude, location.currentLocation.longitude, double.parse(e.value.latitude), double.parse(e.value.longitude)),
                    ),
                  );
                }).toList() : [Center(child:Container(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(LocaleKeys.notFount.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),)],
              )
          ), callbackPersistentContentHeight: (double e) {
            print(e);
        },
        ),
      );
    });

  }
}
