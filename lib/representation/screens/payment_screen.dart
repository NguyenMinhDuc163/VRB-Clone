import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/representation/widgets/app_bar_continer_widget.dart';

import '../../core/constants/assets_path.dart';
import '../../core/themes/app_colors.dart';
import '../widgets/acount_balancea_widget.dart';
import '../widgets/botton_wiget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const routeName = '/payment_screen';
  final String availAccount = "4.000.000";
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<String> items = ['Nhà cung cấp', 'Dịch vụ', 'Option 3'];
  String selectedValue = ''; // Giá trị được chọn mặc định
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Column(children: [
          AppBarContainerWidget(
            title: 'Thanh toán hóa đơn',
          ),
          Divider(
            color: Colors.grey.shade200,
            thickness: 5, // Độ dày của đường thẳng
          ),
          AccountBalanceWidget(
            accountNumber: "0123456789",
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Số dư khả dụng: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.availAccount} VND',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: kMediumPadding,
          ),
          _buildSelectWidget(items, "Dịch vụ"),
          Row(
            children: [
              _buildItem(AssetPath.icoPhone, "Điện thoại"),
              _buildItem(AssetPath.icoInternet, "Điện thoại"),
              _buildItem(AssetPath.icoTv, "Điện thoại"),
              _buildItem(AssetPath.icoFinnace, "Điện thoại"),
            ],
          ),
          _buildSelectWidget(items, 'Nhà cung cấp'),
          TextFormField(
            decoration: InputDecoration(hintText: "Mã KH/SĐT/Số HĐ"),
          ),
          SizedBox(height: kDefaultPadding,),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100
            ),
            child: Row(
              children: [
                Text("Thanh  toán hóa đơn tự động", style: TextStyle(fontSize: 14),),
                SizedBox(width: 110,),
                IconButton(onPressed: (){}, icon: Image.asset(AssetPath.icoButton))
              ],
            ),
          ),
          SizedBox(height: kDefaultPadding,),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
                color: Colors.grey.shade100
            ),
            child: Text("Giao Dich Mau", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.BlueColor),),
          ),
          SizedBox(height: kDefaultPadding,),

          TextField(
            enabled: true,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm danh sách',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.grey.shade900,
                  size: 14,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    kItemPadding,
                  ),
                ),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: kItemPadding),
            ),
            // style: TextStyles.defaultStyle,
            onChanged: (value) {},
            onSubmitted: (String submitValue) {},
          ),
          SizedBox(height: kDefaultPadding,),
          Row(
            children: [
              Image.asset(AssetPath.icoCall),
              SizedBox(width: 30,),
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tên Mẫu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                  SizedBox(height: kMinPadding,),
                  Text("05000210000471", style: TextStyle( fontSize: 14),),
                  SizedBox(height: kMinPadding,),
                  Text("MOBIFONE", style: TextStyle( fontSize: 14),)
                ],
              )
            ],
          ),
          const SizedBox(height: kDefaultPadding,),
          ButtonWidget(onTap: (){}, title: 'Tiếp theo',),
          const SizedBox(height: kDefaultPadding,),
        ]),
      ),
    ),
    );

  }

  Widget _buildItem(String icon, String name) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [Image.asset(icon), Text(name)],
      ),
    );
  }

  Widget _buildSelectWidget(List<String> items, String selectedValue) {
    return DropdownButton<String>(
      isExpanded: true,
      value: selectedValue,
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
          child: Text(value),
        );
      }).toList(),
    );
  }
}
