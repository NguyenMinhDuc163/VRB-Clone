import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddressFormWidget extends StatelessWidget {
  const AddressFormWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.description,
      this.linkMap});
  final String icon;
  final String title;
  final String description;
  final String? linkMap;




  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Container(child: Image.asset(icon)),
        Expanded(child: Container(child: Image.asset(icon))),
        Expanded(
          flex:5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 200,
                child: Text(description,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                    maxLines: 2, // Giới hạn số dòng
                    overflow: TextOverflow.ellipsis,),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: InkWell(
            child: Text('Chỉ đường', style: TextStyle(fontSize: 14, color: Colors.blue.shade900),),
            onTap: () {},
          ),
        )
      ],
    );
  }
}
