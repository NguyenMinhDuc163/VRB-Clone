import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/models/exchange_rate_model.dart';
import 'package:vrb_client/provider/date_provider.dart';
import 'package:vrb_client/provider/exchange_rate_provider.dart';
import 'package:vrb_client/representation/widgets/app_bar_continer_widget.dart';
import 'package:vrb_client/representation/widgets/app_bar_widget.dart';

import '../../core/constants/messages.dart';
import '../../provider/dialog_provider.dart';

class ExchangeRateScreen extends StatefulWidget {
  const ExchangeRateScreen({super.key});
  static String routeName = '/exchange_rate_screen';
  @override
  State<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  bool _isLoading = false;
  // DateTime selectedDate = DateTime.now();
  // String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<ExchangeRateProvider>(context, listen: false)
        .postForeignExchangeRates(
            DateFormat('dd/MM/yyyy').format(DateTime.now()))
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainerWidget(title: "Tỷ lệ giá ngoại tệ"),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer2<ExchangeRateProvider, DateProvider>(
                   builder: (BuildContext context, ExchangeRateProvider rate, DateProvider date, Widget? child) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          const Text(
                            "Tỷ giá ngoại tệ so với VND",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          Column(
                            children: [
                              Text(
                                Messages.exchangeRate1,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: kMinPadding,
                              ),
                              Text(
                                Messages.getExchangeRate2(date.selectedDate),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text("Thời gian", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                                Text(" *", style: TextStyle(color: Colors.red),)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            //TODO time
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('dd/MM/yyyy')
                                        .format(date.selectedDate),
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                  Image.asset(AssetPath.calendar),
                                ],
                              ),
                              onTap: () async {
                                date.selectDate(context);
                                rate.postForeignExchangeRates(
                                    DateFormat('dd/MM/yyyy')
                                        .format(date.selectedDate));
                              },
                            ),
                          ),
                          Container(
                            height: 1, // Chiều cao của đường line
                            color: Colors.grey.shade400, // Màu của đường line
                          ),
                          SizedBox(height: kDefaultPadding,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Đặt bo tròn cho góc của bảng
                              border: Border.all(
                                  width: 1.0,
                                  color: Colors
                                      .grey.shade400), // Đặt border cho bảng
                            ),
                            child: Table(
                              border: TableBorder(
                                horizontalInside: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                  ),
                                  children: [
                                    Container(
                                      height: 50,
                                      child: Center(child: Text('Ngoại tệ')),
                                    ),
                                    Container(
                                      height: 50,
                                      child:
                                      Center(child: Text('Mua tiền mặt')),
                                    ),
                                    Container(
                                      height: 50,
                                      child: Center(
                                          child: Text('Mua chuyển khoản')),
                                    ),
                                    Container(
                                      height: 50,
                                      child: Center(child: Text('Bán')),
                                    ),
                                  ],
                                ),
                                ...rate.exchangeRates.map((rate) => TableRow(
                                  children: [
                                    Container(
                                      height: 50,
                                      child: Center(
                                          child: Text(rate.currencyCode)),
                                    ),
                                    Container(
                                      height: 50,
                                      child:
                                      Center(child: Text(rate.amount)),
                                    ),
                                    Container(
                                      height: 50,
                                      child: Center(
                                          child: Text(rate.amountSell)),
                                    ),
                                    Container(
                                      height: 50,
                                      child: Center(
                                          child: Text(rate.amounTranfer)),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                        ],
                      ),
                    );
      },
                )),
    );
  }
}
