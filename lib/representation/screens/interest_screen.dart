import 'dart:ffi';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/provider/interest_provider.dart';
import 'package:vrb_client/provider/selection_provider.dart';
import '../../core/constants/assets_path.dart';
import '../../core/constants/messages.dart';
import '../widgets/app_bar_continer_widget.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});
  static String routeName = '/interest_screen';
  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  GlobalKey<ExpandableBottomSheetState> key = GlobalKey();
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<InterestProvider>(context, listen: false)
        .postInterestProvider()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }



  String selectedOption = 'Option 1';

  setSelectedOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainerWidget(title: "Lãi xuất"),
      body: Consumer<SelectionProvider>(builder: (context, select, child){
        return ExpandableBottomSheet(
          key: key,
          onIsContractedCallback: () => print('contracted'),
          onIsExtendedCallback: () => print('extended'),
          animationDurationExtend: Duration(milliseconds: 500),
          animationDurationContract: Duration(milliseconds: 250),
          animationCurveExpand: Curves.bounceOut,
          animationCurveContract: Curves.ease,
          persistentContentHeight: select.size.toDouble(), // do rong khi keo xuong


          background: Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: SingleChildScrollView(
              child: _isLoading ? Center(
                child: CircularProgressIndicator(),
              ) : Column(
                children: [

                  SizedBox(height: kDefaultPadding,),
                  Text("Lãi suất dành cho khách hàng cá nhân", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(height: kDefaultPadding,),
                  Container(
                      padding: EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Text(notification, style: TextStyle(fontSize: 14, color: Colors.blue),)
                  ),
                  SizedBox(height: kDefaultPadding,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Loại sản phẩm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),)),
                  // _buildSelectItem(['Gửi tiền trực tuyến có kì hạn', 'Tiền gửi tích luỹ trực tuyến']),

                  //TODO
                  InkWell(
                    onTap: (){
                      print("da an");
                      Provider.of<SelectionProvider>(context, listen: false).changeSize(300);
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("Gửi tiền trực tuyến có kì hạn")),
                          Expanded(child: Image.asset(AssetPath.icoDownBlack)),
                        ],
                      ),

                    ),
                  ),
                  SizedBox(height: kDefaultPadding,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Loại tiền", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),)),
                  _buildSelectItem(['VND', 'USD']),
                  SizedBox(height: kDefaultPadding,),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hình thức trả ", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                          SizedBox(height: kMinPadding * 2,),
                          Text("Trả lãi cuối kì", style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal)),
                          SizedBox(height: kMinPadding,),
                          Container(
                            height: 1, // Chiều cao của đường line
                            color: Colors.grey.shade300, // Màu của đường line
                          ),
                        ],
                      )
                  ),
                  SizedBox(height: kDefaultPadding,),
                  Consumer<InterestProvider>(builder: (context, rate, child){
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Đặt bo tròn cho góc của bảng
                        border: Border.all(
                            width: 1.0,
                            color: Colors
                                .grey.shade400), // Đặt border cho bảng
                      ),
                      child: Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        textBaseline: TextBaseline.alphabetic,
                        border: TableBorder(
                          horizontalInside: BorderSide(width: 1.0, color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(
                                  10.0),),
                            children: [
                              Container(
                                height: 50,
                                child: Center(child: Text('Kì hạn')),
                              ),
                              Container(
                                height: 50,
                                child: Center(child: Text('Lãi xuất')),
                              ),
                            ],
                          ),
                          ...rate.interestRates.map((rate) => TableRow(
                            children: [
                              Container(
                                height: 50,
                                child: Center(child: Text('${rate.termSTR} Tháng')),
                              ),
                              Container(
                                height: 50,
                                child: Center(child: Text(rate.rate)),
                              ),
                            ],
                          )),
                        ],
                      ),
                    );

                  }),
                  SizedBox(height: kDefaultPadding,),
                ],
              ),
            ),
          ),
          //TODO persistentHeader
          persistentHeader: Container(
            height: 100,
            color: Colors.blue,
          ),
          expandableContent: Container(
            constraints: const BoxConstraints.expand(height: 400),
            decoration: const BoxDecoration(
              color: Colors.white,),
            child: Column(
              children: <Widget>[
                RadioListTile(
                  title: Text('Option 1'),
                  value: 'Option 1',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setSelectedOption(value!);
                  },
                ),
                RadioListTile(
                  title: Text('Option 2'),
                  value: 'Option 2',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setSelectedOption(value!);
                  },
                ),
              ],
            ),
          ),
        );
      },),
    );
  }

  Widget _buildSelectItem(List<String> items){
    String? selectedValue = items[0];

    return DropdownButton<String>(
      value: selectedValue,
      isExpanded: true,
      // underline: Container(),
      icon: Image.asset(AssetPath.icoDownBlack),
      onChanged: (String? newValue) {
        // Khi giá trị được chọn thay đổi
        if (newValue != null) {
          // Cập nhật giá trị đã chọn
          setState(() {
            selectedValue = newValue;
          });
        }
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),
        );
      }).toList(),
    );
  }
}
