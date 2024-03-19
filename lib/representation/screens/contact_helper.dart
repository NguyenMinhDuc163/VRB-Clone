import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/representation/widgets/app_bar_continer_widget.dart';

import '../../core/constants/messages.dart';

class ContactHelper extends StatelessWidget {
  const ContactHelper({super.key});
  static String routeName = '/contact_helper';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainerWidget(title: "Liên hệ",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset(AssetPath.helper)),
              Text("NGÂN HÀNG LIÊN DOANH VIỆT - NGA", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Center(child: Text("(VRB)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
              SizedBox(height: kDefaultPadding,),
              _buildRow(Icon(FontAwesomeIcons.phone), 'Hotline', "18006656/ 02439429365"),
              _buildRow(Icon(FontAwesomeIcons.envelopeOpen), 'Email', "vrbhotline@vrbank.com.vn"),
              _buildRow(Icon(FontAwesomeIcons.image), 'Trụ sở chính', address),
              InkWell(
                child: Text("Phiên bản: 1.0.10", style: TextStyle(fontSize: 14, color: Colors.blue.shade800),),
                onTap: (){},
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey), // Viền màu xanh
        ),
        child: InkWell(
          onTap: () {
            // Xử lý sự kiện khi nhấn vào nút
          },
          borderRadius: BorderRadius.all(Radius.circular(20)), // Đảm bảo viền của InkWell cũng bo tròn
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Smart OTP Offline",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget _buildRow(Icon icon, String text1, String text2){
    return Row(
      children: [
        icon,
        SizedBox(width: kDefaultPadding * 2,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text1, style: TextStyle(fontSize: 16),),
            SizedBox(height: kMinPadding,),
            Text(text2, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.start,
            ),
            SizedBox(height: kDefaultPadding,),
          ],
        )
      ],
    );
    
    
  }
}
