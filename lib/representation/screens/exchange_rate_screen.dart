import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/models/exchange_rate_model.dart';
import 'package:vrb_client/provider/exchange_rate_provider.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<ExchangeRateProvider>(context, listen: false)
        .postForeignExchangeRates()
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
          child: _isLoading ? Center(
            child: CircularProgressIndicator(),
          ) : Consumer<ExchangeRateProvider>(
            builder: (context, rate, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
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
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            child: Text(
                              "28/10/2023",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () {
                              rate.postForeignExchangeRates();
                            },
                          ),
                        ),
                        Image.asset(AssetPath.calendar),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0), // Đặt bo tròn cho góc của bảng
                        border: Border.all(width: 1.0, color: Colors.grey.shade400), // Đặt border cho bảng
                      ),
                      child: Table(
                        // border: TableBorder(
                        //   // Đặt border cho tất cả các phần của bảng
                        //   top: BorderSide(width: 1.0, color: Colors.black),
                        //   bottom: BorderSide(width: 1.0, color: Colors.black),
                        //   left: BorderSide(width: 1.0, color: Colors.black),
                        //   right: BorderSide(width: 1.0, color: Colors.black),
                        //   horizontalInside: BorderSide(width: 1.0, color: Colors.black),
                        // ),
                        border: TableBorder.symmetric(inside: BorderSide.none),

                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey.shade300,
                            ),
                            children: [
                              TableCell(
                                child: Center(child: Text('Ngoại tệ')),
                              ),
                              TableCell(
                                child: Center(child: Text('Mua tiền mặt')),
                              ),
                              TableCell(
                                child: Center(child: Text('Mua chuyển khoản')),
                              ),
                              TableCell(
                                child: Center(child: Text('Bán')),
                              )
                            ],
                          ),
                          ...rate.exchangeRates.map((rate) => TableRow(
                                children: [
                                  TableCell(
                                    child: Center(child: Text(rate.currencyCode)),
                                  ),
                                  TableCell(
                                    child: Center(child: Text(rate.amount)),
                                  ),
                                  TableCell(
                                    child: Center(child: Text(rate.amountSell)),
                                  ),
                                  TableCell(
                                    child: Center(child: Text(rate.amounTranfer)),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: kDefaultPadding,),
                  ],
                ),
              );
            },
          )),
    );
  }
}
