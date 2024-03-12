

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:vrb_client/models/district.dart';
import 'package:vrb_client/models/province.dart';

import '../models/bank_location.dart';
import '../models/point.dart';

class DioTest{
  static const String baseURL = 'http://uat.seatechit.com.vn/retail-mobile/api';
  // static String longitude = '105.804706';
  // static String latitude = "21.001357";
 static Future<Map<String, BankLocation>> postBranchATMTypeOne(String longitude, String latitude) async {
   // List<Map<String, Point>> address = [];
   Map<String, BankLocation> address = {};
    try {
      var response = await Dio().post('$baseURL/inquiryProviceInfoList/branhATM', data: {
        "longitude" :  longitude,
        "latitude" : latitude
      });
      // Xử lý dữ liệu nhận được từ yêu cầu ở đây
      // print(response.data);
      if(response.statusCode == 200){
        List<dynamic> obj = jsonDecode(response.data['object']);

        for(var element in obj) {
          int j = 0;
          for(int i = 0; i < element['contains'].length; i++){
            // print(element['contains'][i]);
            // address.add({element['contains'][i]['address'] : Point(element['contains'][i]['longitude'], element['contains'][i]['latitude'])});
            address[element['contains'][i]['address']] = BankLocation(element['contains'][i]['address'], element['contains'][i]['type'],
                element['contains'][i]['shotName'], element['contains'][i]['idImage'], element['contains'][i]['longitude'], element['contains'][i]['latitude']);
          }
        }
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    return address;
  }


  static Future<Map<String, BankLocation>> postBranchATMTypeTwo(String longitude, String latitude, String regionCode1) async {
    Map<String, BankLocation> address = {};
    try {
      var response = await Dio().post('http://uat.seatechit.com.vn/retail-mobile/api/inquiryProviceInfoList/branhATM', data: {
        "longitude" :  longitude,
        "latitude" : latitude,
        "regionCode1" : regionCode1,
      });
      // Xử lý dữ liệu nhận được từ yêu cầu ở đây
      // print(response.data);
      if(response.statusCode == 200){
        List<dynamic> obj = jsonDecode(response.data['object']);
        for(var element in obj) {
          for(int i = 0; i < element['contains'].length; i++){
            address[element['contains'][i]['address']] = BankLocation(element['contains'][i]['address'], element['contains'][i]['type'],
                element['contains'][i]['shotName'], element['contains'][i]['idImage'], element['contains'][i]['longitude'], element['contains'][i]['latitude']);
          }
        }


      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    return address;
  }

   static Future<Map<String, BankLocation>> postBranchATMTypeThree(String longitude, String latitude, String regionCode1, String districtCode) async {
     Map<String, BankLocation> address = {};
    try {
      var response = await Dio().post('http://uat.seatechit.com.vn/retail-mobile/api/inquiryProviceInfoList/branhATM', data: {
        "longitude" :  longitude,
        "latitude" : latitude,
        "regionCode1" : regionCode1,
        'districtCode': districtCode,
      });
      // Xử lý dữ liệu nhận được từ yêu cầu ở đây
      // print(response.data);
      if(response.statusCode == 200){
        List<dynamic> obj = jsonDecode(response.data['object']);
        for(var element in obj) {
          for(int i = 0; i < element['contains'].length; i++){
            address[element['contains'][i]['address']] = BankLocation(element['contains'][i]['address'], element['contains'][i]['type'],
                element['contains'][i]['shotName'], element['contains'][i]['idImage'], element['contains'][i]['longitude'], element['contains'][i]['latitude']);
          }
        }
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    return address;
  }

  static Future<Map<String, Province>> postProvinceInfoList() async {
    Map<String, Province> provinces = {};
    try {
      var response = await Dio().post('$baseURL/inquiryProviceInfoList', data: {});

      if (response.statusCode == 200) {
        List<dynamic> obj = jsonDecode(response.data['object']);
        for (var element in obj) {
          provinces[element['regionName']] = Province(element['regionName'], element['regionCode1']);
        }
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
      // Có thể xử lý lỗi ở đây nếu cần thiết
    }

    return provinces;
  }



  static Future<Map<String, District>> postDistrict(String regionCode1) async {
    Map<String, District> districts = {};
    try {
      var response = await Dio().post('$baseURL/inquiryProviceInfoList/district', data: {
        'regionCode1': regionCode1
      });

      if(response.statusCode == 200){
        List<dynamic> obj = jsonDecode(response.data['object']);
        obj.forEach((element) {
          districts[element['districtName']] = District(element['districtName'], element['districtCode']);
        });
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
      // Có thể xử lý lỗi ở đây nếu cần thiết
    }

    return districts;
  }


}
double calculateDistance(double startLat, double startLng, double endLat, double endLng) {
  const double radius = 6371.0; // Độ lớn của bán kính trái đất trong km
  double latDistance = (endLat - startLat) * (3.141592653589793 / 180);
  double lngDistance = (endLng - startLng) * (3.141592653589793 / 180);
  double a = sin(latDistance / 2) * sin(latDistance / 2) +
      cos(startLat * (3.141592653589793 / 180)) *
          cos(endLat * (3.141592653589793 / 180)) *
          sin(lngDistance / 2) *
          sin(lngDistance / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = radius * c;
  return distance;
}
void main() async {
  String longitude = '105.804706';
  String latitude = "21.001357";
  // Map<String, Province> a = await DioTest.postProvinceInfoList();
  // Map<String, District> b = await DioTest.postDistrict('805');
  print(calculateDistance(21.001357, 105.804706, 22.001357, 105.804706));
}
