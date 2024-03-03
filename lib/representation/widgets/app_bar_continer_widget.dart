import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';

import '../../core/constants/assets_path.dart';

class AppBarContainerWidget extends StatelessWidget {
  const AppBarContainerWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Row(
        children: [
          Expanded(child: IconButton(onPressed: (){}, icon: Image.asset(AssetPath.icoBack)),),
          SizedBox(width: kDefaultPadding * 2,),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),), flex: 3,),
          SizedBox(width: kDefaultPadding * 2,),
          Expanded(child: IconButton(onPressed: (){}, icon: Image.asset(AssetPath.icoHome)), ),
        ],
      ),
    );
  }
}
