import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:vrb_client/models/district.dart';
import 'package:vrb_client/models/province.dart';

import '../models/point.dart';

class DioTest{
  static const String baseURL = 'http://uat.seatechit.com.vn/retail-mobile/api';
  static String longitude = '105.804706';
  static String latitude = "21.001357";
 static Future<Map<String, Point>> postBranchATMTypeOne() async {
   // List<Map<String, Point>> address = [];
   Map<String, Point> address = {};
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
            address[element['contains'][i]['address']] = Point(element['contains'][i]['longitude'], element['contains'][i]['latitude']);
            print('${element['contains'][i]['type']} --- ${element['contains'][i]['shotName']} ${element['contains'][i]['idImage']}');
          }
        }
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    return address;
  }


  static Future<Map<String, Point>> postBranchATMTypeTwo(String regionCode1) async {
    Map<String, Point> address = {};
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
            address[element['contains'][i]['address']] = Point(element['contains'][i]['longitude'], element['contains'][i]['latitude']);
          }
        }


      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    return address;
  }

   static Future<Map<String, Point>> postBranchATMTypeThree(String regionCode1, String districtCode) async {
     Map<String, Point> address = {};
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
            address[element['contains'][i]['address']] = Point(element['contains'][i]['longitude'], element['contains'][i]['latitude']);
          }
        }
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    return address;
  }

  static Future<List<Map<String, Province>>> postProvinceInfoList() async {
    List<Map<String, Province>> provinceLists = [];
    try {
      var response = await Dio().post('$baseURL/inquiryProviceInfoList', data: {});

      if (response.statusCode == 200) {
        List<dynamic> obj = jsonDecode(response.data['object']);
        for (var element in obj) {
          Map<String, Province> province = {}; // Tạo một Map mới cho mỗi phần tử
          province[element['regionName']] = Province(element['regionName'], element['regionCode1']);
          provinceLists.add(province);
        }
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
      // Có thể xử lý lỗi ở đây nếu cần thiết
    }

    return provinceLists;
  }


  static Future<List<Map<String, District>>> postDistrict(String regionCode1) async {
    List<Map<String, District>> districtLists = [];
    try {
      var response = await Dio().post('$baseURL/inquiryProviceInfoList/district', data: {
        'regionCode1': regionCode1
      });

      if(response.statusCode == 200){
        List<dynamic> obj = jsonDecode(response.data['object']);
        obj.forEach((element) {
          Map<String, District> districts = {}; // Tạo một Map mới cho mỗi phần tử
          districts[element['districtName']] = District(element['districtName'], element['districtCode']);
          districtLists.add(districts);
        });
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
      // Có thể xử lý lỗi ở đây nếu cần thiết
    }

    return districtLists;
  }


}

void main() async {
  String longitude = '105.804706';
  String latitude = "21.001357";
  Map<String, Point> a = await DioTest.postBranchATMTypeOne();

  // List<Map<String, District>> b = await DioTest.postDistrict('101');
  // Map<String, Point> c = await DioTest.postBranchATMTypeThree('101', '10111');
  // print(c);
  // print(b);
}
