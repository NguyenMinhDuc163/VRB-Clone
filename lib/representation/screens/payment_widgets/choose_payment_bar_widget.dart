import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';

class ChoosePaymentBarWidget extends StatelessWidget {
  const ChoosePaymentBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 50,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          gradient: AppColor.gradient,
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Text("Nội bộ VRB", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: Center(child: Text("Ngoài VRB", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),)),
            ),
          ),
        ],
      ),
    );
  }
}
