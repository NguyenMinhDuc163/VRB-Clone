import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:vrb_client/models/district.dart';
import 'package:vrb_client/models/province.dart';

import '../models/point.dart';

class DioTest{
  static const String baseURL = 'http://uat.seatechit.com.vn/retail-mobile/api';
  static String longitude = '105.804706';
  static String latitude = "21.001357";
 static Future<List<Map<String, Point>>> postBranchATMTypeOne() async {
   List<Map<String, Point>> address = [];

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
          address.add({element['contains'][0]['address'] : Point(element['contains'][0]['longitude'], element['contains'][0]['latitude'])});
        };
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    return address;
  }


  static Future<List<Map<String, Point>>> postBranchATMTypeTwo(String regionCode1) async {
    List<Map<String, Point>> address = [];
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
          address.add({element['contains'][0]['address'] : Point(element['contains'][0]['longitude'], element['contains'][0]['latitude'])});
        }
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    return address;
  }

   static Future<List<Map<String, Point>>> postBranchATMTypeThree(String regionCode1, String districtCode) async {
     List<Map<String, Point>> address = [];
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
          address.add({element['contains'][0]['address'] : Point(element['contains'][0]['longitude'], element['contains'][0]['latitude'])});
        }
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    return address;
  }

   static Future<Map<String, Province>> postProviceInfoList() async {
     Map<String, Province> province = {};
     try {
      var response = await Dio().post('$baseURL/inquiryProviceInfoList', data: {

      });
      // Xử lý dữ liệu nhận được từ yêu cầu ở đây
      // print(response.data);
      if(response.statusCode == 200){
        // print(response.data['object']);
        List<dynamic> obj = jsonDecode(response.data['object']);
        for(var element in obj) {
          // province.add(Province(element['regionName'], element['regionCode1']));
          province[element['regionName']] = Province(element['regionName'],element['regionCode1'], await postDistrict(element['regionCode1']));
        };
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    province['Tỉnh/ Thành Phố'] = Province('Quận/ Huyện', '99999', {'Quận/ Huyện': District('Quận/ Huyện', '99999')});
    // province['Tỉnh/ Thành Phố'] = Province('Quận/ Huyện', '99999', {});

  return province;

  }

  static Future<Map<String, District>> postDistrict(String regionCode1) async {
    // List<District> districts = [];
    final Map<String, District> districts = {};
    try {
      var response = await Dio().post('$baseURL/inquiryProviceInfoList/district', data: {
        'regionCode1': regionCode1
      });
      // Xử lý dữ liệu nhận được từ yêu cầu ở đây
      // print(response.data);

      if(response.statusCode == 200){
        List<dynamic> obj = jsonDecode(response.data['object']);
        obj.forEach((element) {
          // districts.add(District(element['districtName'], element['districtCode']));
          districts[element['districtName']] = District(element['districtName'], element['districtCode']);
        });
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    districts['Quận/ Huyện'] = District('Quận/ Huyện', '99999');

    return districts;
  }

}

void main() async {
  String longitude = '105.804706';
  String latitude = "21.001357";
  DioTest.postBranchATMTypeThree('717', '71712');
}
