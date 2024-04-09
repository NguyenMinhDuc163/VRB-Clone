import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/core/themes/app_colors.dart';
import 'package:vrb_client/representation/screens/payment_screens/search_bank_screen.dart';
import 'package:vrb_client/representation/screens/payment_widgets/choose_payment_bar_widget.dart';
import 'package:vrb_client/representation/screens/payment_widgets/search_list_bank_widget.dart';
import 'package:vrb_client/representation/widgets/app_bar_continer_widget.dart';

import '../../../core/constants/assets_path.dart';
import '../payment_widgets/list_bank_history_widget.dart';
import '../payment_widgets/list_view_widget.dart';
import '../payment_widgets/row_button_widget.dart';
import '../payment_widgets/select_account_widget.dart';

class OutsideBankPaymentScreen extends StatefulWidget {
  const OutsideBankPaymentScreen({super.key});
  static String routeName = 'outside_bank_payment_screen';
  @override
  State<OutsideBankPaymentScreen> createState() => _OutsideBankPaymentScreenState();
}

class _OutsideBankPaymentScreenState extends State<OutsideBankPaymentScreen> {
  int _selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior
          .translucent, // Cho phép GestureDetector bắt sự kiện trên toàn bộ khu vực widget
      onTap: () {
        // Khi bên ngoài form được chạm, ẩn bàn phím bằng cách mất trọng tâm
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: const AppBarContainerWidget(title: 'Chọn người thụ hưởng', chooseHome: true,),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ChoosePaymentBarWidget(),
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text('Số tài khoản', style: TextStyle(fontSize: 14),),value: 0, groupValue: _selectedValue, onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        }),),
                      Expanded(
                        child: RadioListTile(
                            contentPadding: EdgeInsets.zero,title: Text('Số thẻ', style: TextStyle(fontSize: 14)),value: 1, groupValue: _selectedValue, onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        }),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text("Tài khoản nguồn", style: TextStyle(color: Colors.grey.shade700),),
                    Text(' *', style: TextStyle(color: Colors.red),)
                  ],
                ),
                const SelectItemWidget(title: '123456789 - VND ',),
                SizedBox(height: kMinPadding,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Số dư khả dụng: "),
                    Text('12,000,000 VND', style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        List<String> data = ['123', '456'];
                        Navigator.of(context).pushNamed(SearchBankScreen.routeName, arguments: {'searchTerms': data, 'titleField': 'Chọn ngân hàng thụ hưởng'});
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                                  'Chọn ngân hàng thụ hưởng',
                                  style: TextStyle(fontSize: 16),
                                )),
                            Image.asset(AssetPath.icoDownBold),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 1, color: Colors.grey.shade400,)
                  ],
                ),
                SizedBox(height: kDefaultPadding,),
                Text('Gợi ý', style: TextStyle(fontSize: 16, color: Colors.grey.shade600),),
                ListViewWidget(),
                RowBottonWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: SearchListBankWidget()),
                    SizedBox(width: kDefaultPadding,),
                    Text('Danh sách', style: TextStyle(color: Colors.blue.shade800),)
                  ],
                ),
                ListBankHistoryWidget()

              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            gradient: AppColor.gradient
          ),
          child: InkWell(
            onTap: () {
              // Xử lý sự kiện khi nhấn vào nút
            },
            borderRadius: BorderRadius.all(Radius.circular(10)), // Đảm bảo viền của InkWell cũng bo tròn
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Tiếp tục",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
