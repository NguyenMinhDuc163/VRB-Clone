import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/exchange_rate_model.dart';
import '../models/interest_model.dart';

class InterestProvider extends ChangeNotifier{
  static const String baseURL = 'http://uat.seatechit.com.vn/corp-mobile/api/';
  List<InterestModel> _interestModels = [];

  List<InterestModel> get interestRates{
    return _interestModels;
  }
  Future<List<InterestModel>> postInterestProvider() async {

    try {
      var response = await Dio().post('$baseURL/getInterestRate', data:
      {"userId": "", "currencyCode": "VND", "category": "FS", "language": "vi_VN", "dataHTLL": "LINH_LAI_CUOI_KY"});
      List<InterestModel> loadInterestModel = [];
      if(response.statusCode == 200){
        List<dynamic> obj = jsonDecode(response.data['data']);
        obj.forEach((element) {
          loadInterestModel.add(
              InterestModel(element['rate'].toString(), element['productCode'], element['termSTR'])
          );
        });
      }
      _interestModels = loadInterestModel;
        notifyListeners();
        return _interestModels;
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu 2: $e');
      throw e;
    }
  }
}

void main() async{
  List<InterestModel> list = await InterestProvider().postInterestProvider();
  list.forEach((element) {
    print(element);
  });
}