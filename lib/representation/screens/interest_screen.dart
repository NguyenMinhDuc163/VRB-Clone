import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/provider/interest_provider.dart';
import 'package:vrb_client/provider/selection_provider.dart';
import '../../core/constants/assets_path.dart';
import '../../core/constants/messages.dart';
import '../../provider/dialog_provider.dart';
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
  int _size = 400;
  final FocusNode _focusNode = FocusNode();


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

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarContainerWidget(title: "Lãi xuất"),
      body: Consumer<SelectionProvider>(builder: (context, select, child){
        return WillPopScope( // xu ly khi pop
          onWillPop: () async {
            Provider.of<SelectionProvider>(context, listen: false).changeSize(0, 0);
            // Thêm xử lý của bạn ở đây
            // Nếu bạn muốn ngăn chặn việc quay lại, return false
            // Nếu bạn muốn cho phép việc quay lại, return true
            return true; // hoặc false tùy thuộc vào logic của bạn
          },
          child: GestureDetector(
            behavior: HitTestBehavior.translucent, // Cho phép GestureDetector bắt sự kiện trên toàn bộ khu vực widget
            onTap: () {
              Provider.of<SelectionProvider>(context, listen: false).changeSize(0, 0);
              // Khi bên ngoài form được chạm, ẩn bàn phím bằng cách mất trọng tâm
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ExpandableBottomSheet(
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
                child: _isLoading ? const Center(
                  child: CircularProgressIndicator(),
                ) :  SingleChildScrollView(
                  child:Column(
                    children: [
            
                      const SizedBox(height: kDefaultPadding,),
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
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Loại sản phẩm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),)),
            
                      //TODO choose 1
                      InkWell(
                        onTap: () async {
                          Provider.of<SelectionProvider>(context, listen: false).changeSize(_size, 0);
                        },
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(select.typeProduct, style: const TextStyle(fontSize: 18),)),
                              Image.asset(AssetPath.icoDownBold),
                            ],
                          ),
            
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding,),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Loại tiền", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),)),
                      //TODO choose 2
                      InkWell(
                        onTap: (){
                          Provider.of<SelectionProvider>(context, listen: false).changeSize(_size, 1);
                        },
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(select.typeMoney, style: TextStyle(fontSize: 18),)),
                              Image.asset(AssetPath.icoDownBold),
                            ],
                          ),
            
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding,),
            
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Hình thức trả ", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                              const SizedBox(height: kMinPadding * 2,),
                              const Text("Trả lãi cuối kì", style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal)),
                              const SizedBox(height: kMinPadding,),
                              Container(
                                height: 1, // Chiều cao của đường line
                                color: Colors.grey.shade300, // Màu của đường line
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: kDefaultPadding,),
                      Consumer<InterestProvider>(builder: (context, rate, child){
                        return  (select.typeMoney == "USD" && select.typeProduct == 'Tiền gửi tích luỹ trực tuyến') ? Column(
                          children: [
                            Image.asset(AssetPath.notFound),
                            const Text("Hiện không có dữ liệu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          ],
                        ): Container(
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
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),),
                                children: const [
                                  SizedBox(
                                    height: 50,
                                    child: Center(child: Text('Kì hạn', style: TextStyle( fontSize: 15,fontWeight: FontWeight.bold),)),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Center(child: Text('Lãi xuất (%/Năm)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
                                  ),
                                ],
                              ),
                              ...rate.interestRates.map((rate) => TableRow(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Center(child: Text('${rate.termSTR} Tháng')),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Center(child: Text(rate.rate)),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        );
            
                      }),
                      const SizedBox(height: kDefaultPadding,),
                    ],
                  ),
                ),
              ),
              //TODO persistentHeader
              // persistentHeader: Container(
              //   height: 30,
              //   color: Colors.blue,
              // ),
              expandableContent: Container(
                constraints: BoxConstraints.expand(
                    height: select.size.toDouble()
          ),
                decoration:  BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: _buildChoseItem(context),
              ),
            ),
          ),
        );
      },),
    );
  }

  Widget _buildChoseItem(BuildContext context){
    return Consumer<SelectionProvider>(builder: (context, select, child){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text((select.type == 0) ? "Chọn loại sản phẩm" : "Chọn loại tiền",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                InkWell(
                    onTap: (){
                      Provider.of<SelectionProvider>(context, listen: false).changeSize(0, 0);
                    },
                    child: Icon(FontAwesomeIcons.xmark))
              ],
            ),
          ),
          RadioListTile(
            title: (select.type == 0) ? Text(select.listChoose[0]) : Text(select.listMoney[0]),
            value: (select.type == 0) ? select.listChoose[0] : select.listMoney[0],
            groupValue: (select.type == 0) ? select.typeProduct : select.typeMoney,
            onChanged: (value) async {
              Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
              await Future.delayed(Duration(milliseconds: 200)); // Đợi trong 2 giây
              select.changeSelect(value!, select.type);
              Provider.of<SelectionProvider>(context, listen: false).changeSize(0, 0);
              Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
              setState(() {
                _isLoading = false;
              });
            },
          ),
          RadioListTile(
            title: (select.type == 0) ? Text(select.listChoose[1]) : Text(select.listMoney[1]),
            value: (select.type == 0) ? select.listChoose[1] : select.listMoney[1],
            groupValue: (select.type == 0) ? select.typeProduct : select.typeMoney,
            onChanged: (value) async {
              Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
              await Future.delayed(Duration(milliseconds: 200)); // Đợi trong 2 giây
              select.changeSelect(value!, select.type);
              Provider.of<SelectionProvider>(context, listen: false).changeSize(0, 0);
              Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
            },
          ),
        ],
      );
    });
  }


}
