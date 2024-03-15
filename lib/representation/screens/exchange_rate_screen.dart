import 'package:flutter/material.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/representation/widgets/app_bar_continer_widget.dart';
import 'package:vrb_client/representation/widgets/app_bar_widget.dart';

import '../../core/constants/messages.dart';

class ExchangeRateScreen extends StatefulWidget {
  const ExchangeRateScreen({super.key});
  static String routeName = '/exchange_rate_screen';
  @override
  State<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarContainerWidget(title: "Tỷ lệ giá ngoại tệ"),
            const SizedBox(
              height: kDefaultPadding,
            ),
            const Text(
              "Tỷ giá ngoại tệ so với VND",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            const Column(
              children: [
                Text(
                  ExchangeRate1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: kMinPadding,
                ),
                Text(
                  ExchangeRate2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: InkWell(
                    child: Text(
                      "28/10/2023",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                Image.asset(AssetPath.calendar),
              ],
            ),

          ],
        ),
      ),
    );

  }
}

