import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';

import '../../core/constants/assets_path.dart';

class AppBarContainerWidget extends StatelessWidget implements PreferredSizeWidget{
  const AppBarContainerWidget({super.key, required this.title});

  final String title;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 28.0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Image.asset(AssetPath.icoBack)),),
              // SizedBox(width: kDefaultPadding * 2,),
              Align(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
              // SizedBox(width: kDefaultPadding * 2,),
              Container(child: IconButton(onPressed: (){}, icon: Image.asset(AssetPath.icoHome)),),
            ],
          ),
          Container(
            height: 6, // Chiều cao của đường line
            color: Colors.grey.shade300, // Màu của đường line
          ),
        ],
      ),
    );
  }
}
