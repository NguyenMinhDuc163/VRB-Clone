import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';
import 'package:vrb_client/provider/interest_provider.dart';
import 'package:vrb_client/provider/selection_provider.dart';
import 'package:vrb_client/representation/widgets/app_bar_continer_widget.dart';
import '../../core/constants/assets_path.dart';
import '../../core/constants/messages.dart';
import '../../provider/dialog_provider.dart';

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


  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.25, // Kích thước tối thiểu 25% của chiều cao màn hình
          maxChildSize: 0.7, // Kích thước tối đa 75% của chiều cao màn hình
          initialChildSize: 0.5, // Kích thước ban đầu là 50% của chiều cao màn hình
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: _buildChoseItem(context),
            );
          },
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarContainerWidget(title: LocaleKeys.interestTitle.tr()),
      body: Consumer<SelectionProvider>(
        builder: (context, select, child) {
          return WillPopScope(
            // xu ly khi pop
            onWillPop: () async {
              Provider.of<SelectionProvider>(context, listen: false)
                  .changeSize(0, 0);
              //int Thêm xử lý của bạn ở đây
              // Nếu bạn muốn ngăn chặn việc quay lại, return false
              // Nếu bạn muốn cho phép việc quay lại, return true
              return true; // hoặc false tùy thuộc vào logic của bạn
            },
            child: GestureDetector(
              behavior: HitTestBehavior
                  .translucent, // Cho phép GestureDetector bắt sự kiện trên toàn bộ khu vực widget
              onTap: () {
                Provider.of<SelectionProvider>(context, listen: false)
                    .changeSize(0, 0);
                // Khi bên ngoài form được chạm, ẩn bàn phím bằng cách mất trọng tâm
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: _isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        LocaleKeys.individualRate.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Container(
                          padding: EdgeInsets.all(kDefaultPadding),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10))),
                          child: Text(
                            LocaleKeys.notification.tr(),
                            style: TextStyle(
                                fontSize: 14, color: Colors.blue),
                          )),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            LocaleKeys.productType.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )),

                      //TODO choose 1
                      InkWell(
                        onTap: () async {
                          // Provider.of<SelectionProvider>(context,
                          //     listen: false)
                          //     .changeSize(_size, 0);
                          _showBottomSheet(context);
                        },
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                    select.typeProduct,
                                    style: const TextStyle(fontSize: 18),
                                  )),
                              Image.asset(AssetPath.icoDownBold),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            LocaleKeys.currencyType.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )),
                      //TODO choose 2
                      InkWell(
                        onTap: () {
                          // Provider.of<SelectionProvider>(context,
                          //     listen: false)
                          //     .changeSize(_size, 1);
                          _showBottomSheet(context);
                        },
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                    select.typeMoney,
                                    style: TextStyle(fontSize: 18),
                                  )),
                              Image.asset(AssetPath.icoDownBold),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),

                      Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.calc.tr(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: kMinPadding * 2,
                              ),
                              Text(LocaleKeys.payInterest.tr(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal)),
                              const SizedBox(
                                height: kMinPadding,
                              ),
                              Container(
                                height: 1, // Chiều cao của đường line
                                color: Colors.grey
                                    .shade300, // Màu của đường line
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Consumer<InterestProvider>(
                          builder: (context, rate, child) {
                            return (select.typeMoney == "USD" &&
                                select.typeProduct ==
                                    LocaleKeys.typeProduct1.tr())
                                ? Column(
                              children: [
                                Image.asset(AssetPath.notFound),
                                Text(
                                  LocaleKeys.dataEmpty.tr(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                                : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Đặt bo tròn cho góc của bảng
                                border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey
                                        .shade400), // Đặt border cho bảng
                              ),
                              child: Table(
                                defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                                textBaseline: TextBaseline.alphabetic,
                                border: TableBorder(
                                  horizontalInside: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300),
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                ),
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: const BorderRadius
                                          .vertical(
                                          top: Radius.circular(10)),
                                    ),
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                              LocaleKeys.tenor.tr(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                              LocaleKeys.rate.tr(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            )),
                                      ),
                                    ],
                                  ),
                                  ...rate.interestRates
                                      .map((rate) => TableRow(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                                '${rate.termSTR} ${LocaleKeys.month.tr()}')),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                                rate.rate)),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            );
                          }),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChoseItem(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, select, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (select.type == 0) ? LocaleKeys.chooseProduct.tr() : LocaleKeys.chooseMoney.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                InkWell(
                    onTap: () {
                      // Provider.of<SelectionProvider>(context, listen: false)
                      //     .changeSize(0, 0);
                      Navigator.pop(context);
                    },
                    child: Icon(FontAwesomeIcons.xmark))
              ],
            ),
          ),
          RadioListTile(
            title: (select.type == 0)
                ? Text(LocaleKeys.typeProduct1.tr())
                : Text(select.listMoney[0]),
            value:
            (select.type == 0) ? LocaleKeys.typeProduct1.tr() : select.listMoney[0],
            groupValue:
            (select.type == 0) ? select.typeProduct : select.typeMoney,
            onChanged: (value) async {
              Provider.of<DialogProvider>(context, listen: false)
                  .showLoadingDialog(context);
              await Future.delayed(
                  Duration(milliseconds: 200)); // Đợi trong 2 giây
              select.changeSelect(value!, select.type);
              // Provider.of<SelectionProvider>(context, listen: false)
              //     .changeSize(0, 0);
              Navigator.pop(context);
              Provider.of<DialogProvider>(context, listen: false)
                  .hideLoadingDialog(context);
              setState(() {
                _isLoading = false;
              });
            },
          ),
          RadioListTile(
            title: (select.type == 0)
                ? Text(LocaleKeys.typeProduct2.tr())
                : Text(select.listMoney[1]),
            value:
            (select.type == 0) ? LocaleKeys.typeProduct2.tr() : select.listMoney[1],
            groupValue:
            (select.type == 0) ? select.typeProduct : select.typeMoney,
            onChanged: (value) async {
              Provider.of<DialogProvider>(context, listen: false)
                  .showLoadingDialog(context);
              await Future.delayed(
                  Duration(milliseconds: 200)); // Đợi trong 2 giây
              select.changeSelect(value!, select.type);
              // Provider.of<SelectionProvider>(context, listen: false)
              //     .changeSize(0, 0);
              Navigator.pop(context);
              Provider.of<DialogProvider>(context, listen: false)
                  .hideLoadingDialog(context);
            },
          ),
        ],
      );
    });
  }
}
