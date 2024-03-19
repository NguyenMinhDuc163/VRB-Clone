import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../models/exchange_rate_model.dart';

class ExchangeRateProvider extends ChangeNotifier{
  static const String baseURL = 'http://uat.seatechit.com.vn/corp-mobile/api/';
  List<ExchangeRateModel> _exchangeRates = [];
  List<ExchangeRateModel> get exchangeRates{
    return _exchangeRates;
  }
   Future<List<ExchangeRateModel>> postForeignExchangeRates(String date) async {

    try {
      var response = await Dio().post(
          '$baseURL/lookUpForeignExchangeRatesAPI', data:
      {"exchange_dateStr": date});
      List<ExchangeRateModel> loadExchangeRates = [];
      if (response.statusCode == 200) {
        List<dynamic> obj = jsonDecode(response.data['object']);
        obj.forEach((element) {
          loadExchangeRates.add(
              ExchangeRateModel(element['currency_code'], element['amount'], element['amount_sell'], element['amount_tranfer'])
          );
        });
      }
      _exchangeRates = loadExchangeRates;
      notifyListeners();
      return _exchangeRates;
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu 2: $e');
      throw e;
    }
  }
}

void main() async{
  // List<ExchangeRateModel> list = await ExchangeRateProvider().postForeignExchangeRates();
  // list.forEach((element) {
  //   print(element);
  // });
}