import 'dart:convert';

import 'package:dio/dio.dart';

class RateRequest {
  static const String baseURL = 'http://uat.seatechit.com.vn/corp-mobile/api/';

  static void postName() async {
    try {
      var response = await Dio().post('$baseURL/getCategogyName', data: {"language": "vi_VN"});
      // Xử lý dữ liệu nhận được từ yêu cầu ở đây
      // print(response.data);
      if(response.statusCode == 200){
        Map<String, dynamic> obj = jsonDecode(response.data['object']);
        obj.forEach((key, value) {
          var x = jsonDecode(value);
          print('$key --- $x');
        });
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu 1: $e');
    }
  }


  static void postInterestRate() async {
    try {
      var response = await Dio().post('$baseURL/getInterestRate', data:
      {"userId": "", "currencyCode": "VND", "category": "FS", "language": "vi_VN", "dataHTLL": "LINH_LAI_CUOI_KY"});
      if(response.statusCode == 200){
        List<dynamic> obj = jsonDecode(response.data['data']);
        obj.forEach((element) {
          print(element);
        });
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu 2: $e');
    }
  }


  static void postForeignExchangeRates() async {
    try {
      var response = await Dio().post('$baseURL/lookUpForeignExchangeRatesAPI', data:
      {"exchange_dateStr": "14/03/2024"});
      if(response.statusCode == 200){
        List<dynamic> obj = jsonDecode(response.data['object']);
        obj.forEach((element) {
          print(element);
        });
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu 2: $e');
    }
  }
}

void main() {
  RateRequest.postInterestRate();
}
