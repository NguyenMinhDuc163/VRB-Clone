import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:remove_diacritic/remove_diacritic.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';

import '../../provider/dialog_provider.dart';
import '../../provider/location_provider.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key, required this.searchTerms, required this.titleField});
  static const String routeName = '/search_location_screen';
  final List<String> searchTerms;
  final String titleField;
  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController _searchController = TextEditingController();
  // bool isSearchClicked = false;
  // String searchText = '';
  // List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).filteredItems = List.from(widget.searchTerms);
  }

  void _onSearchChanged(String value) {
    setState(() {
      Provider.of<LocationProvider>(context, listen: false).searchText = value;
      myFilterItems();
    });
  }

  void myFilterItems() {
    LocationProvider location  = Provider.of<LocationProvider>(context, listen: false);
    if (location.searchText.isEmpty) {
      location.filteredItems = List.from(widget.searchTerms);
    } else {
      String textChoose = removeDiacritics(location.searchText);
      location.filteredItems = widget.searchTerms
          .where(
              (item) => (removeDiacritics(item.toLowerCase()).contains(textChoose.toLowerCase())
                  || item.toLowerCase().contains(textChoose.toLowerCase() )))
          .toList();
    }
  }
  Future<bool> _onWillPop() async {
    var tmp = Provider.of<LocationProvider>(context, listen: false);
    (widget.titleField == LocaleKeys.province.tr()) ?
      Navigator.pop(context,tmp.provinceChose ?? widget.titleField)
    : Navigator.pop(context,tmp.districtChose ?? widget.titleField);
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
      child: GestureDetector(
        behavior: HitTestBehavior
            .translucent, // Cho phép GestureDetector bắt sự kiện trên toàn bộ khu vực widget
        onTap: () {
          // Khi bên ngoài form được chạm, ẩn bàn phím bằng cách mất trọng tâm
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Consumer<LocationProvider>(builder: (context, location, _){
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.titleField,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Container(
                          child: InkWell(
                            onTap: _onWillPop,
                            child: const Icon(FontAwesomeIcons.xmark),
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildSearch(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: (location.filteredItems.isEmpty || widget.searchTerms.isEmpty)
                          ?  Center(child: Text(LocaleKeys.notFoundData.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),)
                          :ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: location.filteredItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(location.filteredItems[index]),
                            onTap: () {
                              _onItemTapped(location.filteredItems[index]); // Gọi hàm khi một mục được chọn
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(String selectedItem) {
    Navigator.pop(context, selectedItem); // Trả về giá trị đã chọn khi quay lại màn hình trước
  }


  Widget _buildSearch() {

    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey.shade100,
        // thay doi mau vien
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: LocaleKeys.searchLocal.tr(),
          hintStyle: TextStyle(fontSize: 18),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: 12.0), ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
