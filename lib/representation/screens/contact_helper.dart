import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';
import 'package:vrb_client/representation/widgets/app_bar_continer_widget.dart';

import '../../core/constants/messages.dart';

class ContactHelper extends StatelessWidget {
  const ContactHelper({super.key});
  static String routeName = '/contact_helper';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainerWidget(title: LocaleKeys.contactTitle.tr(),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset(AssetPath.helper)),
              SizedBox(height: kDefaultPadding,),
              Text(LocaleKeys.slogan.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Center(child: Text("(VRB)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
              SizedBox(height: kDefaultPadding,),
              _buildRow(Icon(FontAwesomeIcons.phone), 'Hotline', "18006656/ 02439429365", onTap: _makePhoneCall),
              _buildRow(Icon(FontAwesomeIcons.envelopeOpen), 'Email', "vrbhotline@vrbank.com.vn", onTap: _launchEmail),
              _buildRow(Icon(FontAwesomeIcons.image), LocaleKeys.headOffice.tr(), LocaleKeys.address.tr()),
              InkWell(
                child: Text(LocaleKeys.version.tr(), style: TextStyle(fontSize: 14, color: Colors.blue.shade800),),
                onTap: (){},
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                color: Colors.blue.shade800,
              ),
            ),
          ),
        ),
      )
    );
  }
  _makePhoneCall() async {
    const String telUrl = 'tel:18006656';
    final Uri uri = Uri.parse(telUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Không thể gọi số điện thoại';
    }
  }
  _launchEmail() async {
    const String email = 'vrbhotline@vrbank.com.vn';
    final Uri emailUri = Uri.parse('mailto:$email');

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Không thể mở ứng dụng email';
    }
  }

  Widget _buildRow(Icon icon, String text1, String text2, {Function()? onTap}){
    return Row(
      children: [
        icon,
        const SizedBox(width: kDefaultPadding * 2,),
        InkWell(
          onTap:(onTap != null) ? onTap : (){},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text1, style: const TextStyle(fontSize: 16),),
              const SizedBox(height: kMinPadding,),
              Text(text2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textAlign: TextAlign.start,
              ),
              const SizedBox(height: kDefaultPadding,),
            ],
          ),
        )
      ],
    );
    
    
  }
}
