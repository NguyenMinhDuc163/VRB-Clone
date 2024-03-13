

import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:vrb_client/models/district.dart';
import 'package:vrb_client/models/province.dart';

import '../models/bank_location.dart';

class DioTest{
  static const String baseURL = 'http://uat.seatechit.com.vn/retail-mobile/api';
  // static String longitude = '105.804706';
  // static String latitude = "21.001357";
 static Future<List<Map<String, BankLocation>>> postBranchATMTypeOne(String longitude, String latitude) async {
   // List<Map<String, Point>> address = [];
   List<Map<String, BankLocation>> addressList = [];
   Map<String, BankLocation> atmMap = {};
   Map<String, BankLocation> branchMap = {};
   print(longitude);
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
          for(int i = 0; i < element['contains'].length; i++){
            if(element['contains'][i]['type'] == 'ATM'){
              atmMap[element['contains'][i]['address']] = BankLocation(element['contains'][i]['address'], element['contains'][i]['type'],
                  element['contains'][i]['shotName'], element['contains'][i]['idImage'], element['contains'][i]['longitude'], element['contains'][i]['latitude']);
            }
            else{
              branchMap[element['contains'][i]['address']] = BankLocation(element['contains'][i]['address'], element['contains'][i]['type'],
                  element['contains'][i]['shotName'], element['contains'][i]['idImage'], element['contains'][i]['longitude'], element['contains'][i]['latitude']);
            }
          }
        }
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu 1: $e');
    }
    return [atmMap, branchMap];
  }


  static Future<List<Map<String, BankLocation>>> postBranchATMTypeTwo(String longitude, String latitude, String regionCode1) async {
    // Map<String, BankLocation> address = {};
    Map<String, BankLocation> atmMap = {};
    Map<String, BankLocation> branchMap = {};
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
            if(element['contains'][i]['type'] == 'ATM'){
              atmMap[element['contains'][i]['address']] = BankLocation(element['contains'][i]['address'], element['contains'][i]['type'],
                  element['contains'][i]['shotName'], element['contains'][i]['idImage'], element['contains'][i]['longitude'], element['contains'][i]['latitude']);
            }
            else{
              branchMap[element['contains'][i]['address']] = BankLocation(element['contains'][i]['address'], element['contains'][i]['type'],
                  element['contains'][i]['shotName'], element['contains'][i]['idImage'], element['contains'][i]['longitude'], element['contains'][i]['latitude']);
            }
          }
        }


      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu 3: $e');
    }
    return [atmMap, branchMap];
  }

   static Future<List<Map<String, BankLocation>>> postBranchATMTypeThree(String longitude, String latitude, String regionCode1, String districtCode) async {
     // Map<String, BankLocation> address = {};
     Map<String, BankLocation> atmMap = {};
     Map<String, BankLocation> branchMap = {};
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
            if(element['contains'][i]['type'] == 'ATM'){
              atmMap[element['contains'][i]['address']] = BankLocation(element['contains'][i]['address'], element['contains'][i]['type'],
                  element['contains'][i]['shotName'], element['contains'][i]['idImage'], element['contains'][i]['longitude'], element['contains'][i]['latitude']);
            }
            else{
              branchMap[element['contains'][i]['address']] = BankLocation(element['contains'][i]['address'], element['contains'][i]['type'],
                  element['contains'][i]['shotName'], element['contains'][i]['idImage'], element['contains'][i]['longitude'], element['contains'][i]['latitude']);
            }
          }
        }
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu 4: $e');
    }
    return [atmMap, branchMap];
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
      print('Đã xảy ra lỗi khi thực hiện yêu cầu 5: $e');
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
      print('Đã xảy ra lỗi khi thực hiện yêu cầu 6: $e');
      // Có thể xử lý lỗi ở đây nếu cần thiết
    }

    return districts;
  }


}

void main() async {
  String longitude = '105.804706';
  String latitude = "21.001357";
  var a = await DioTest.postBranchATMTypeTwo(longitude, latitude, '805');

  a.forEach((element) {
    print(element);
    print("-----------------");
  });
}
