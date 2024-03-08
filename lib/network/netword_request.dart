import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:vrb_client/models/district.dart';
import 'package:vrb_client/models/province.dart';

import '../models/province.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
class DioTest{
  static const String baseURL = 'http://uat.seatechit.com.vn/retail-mobile/api';

  void postBranchATMTypeOne(String longitude, String latitude) async {
    try {
      var response = await Dio().post('$baseURL/inquiryProviceInfoList/branhATM', data: {
        "longitude" :  longitude,
        "latitude" : latitude
      });
      // Xử lý dữ liệu nhận được từ yêu cầu ở đây
      // print(response.data);
      if(response.statusCode == 200){
        List<dynamic> obj = jsonDecode(response.data['object']);
        obj.forEach((element) {
          // print(element['contains'][0]['longitude']);
          // print(element['contains'][0]['latitude']);
          print(element['contains'][0]);
        });
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
  }


   void postBranchATMTypeTwo(String longitude, String latitude, String regionCode1) async {
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
        obj.forEach((element) {
          print(element['contains'][2]);
        });
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
  }

   void postBranchATMTypeThree(String longitude, String latitude, String regionCode1, String districtCode) async {
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
        obj.forEach((element) {
          print(element['contains'][2]);
        });
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
  }

   static Future<List<Province>> postProviceInfoList() async {
    List<Province> province = [];
    try {
      var response = await Dio().post('$baseURL/inquiryProviceInfoList', data: {

      });
      // Xử lý dữ liệu nhận được từ yêu cầu ở đây
      // print(response.data);
      if(response.statusCode == 200){
        // print(response.data['object']);
        List<dynamic> obj = jsonDecode(response.data['object']);
        obj.forEach((element) {
          province.add(Province(element['regionName'], element['regionCode1']));
        });
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }
    province;
  return province;

  }

  static Future<List<District>> postDistrict(String regionCode1) async {
    List<District> districts = [];
    try {
      var response = await Dio().post('$baseURL/inquiryProviceInfoList/district', data: {
        'regionCode1': regionCode1
      });
      // Xử lý dữ liệu nhận được từ yêu cầu ở đây
      // print(response.data);

      if(response.statusCode == 200){
        List<dynamic> obj = jsonDecode(response.data['object']);
        obj.forEach((element) {
          districts.add(District(element['districtName'], element['districtCode']));
        });
      }
    } catch (e) {
      print('Đã xảy ra lỗi khi thực hiện yêu cầu: $e');
    }districts.add(District('Quận/ Huyện', '99999'));

    return districts;
  }

  static Future<Map<Province, List<District>>> fetchLocation() async {
    List<Province> province = await postProviceInfoList();
    Map<Province, List<District>> locations = {};
    for(var x in province){
      locations[x] = await postDistrict(x.regionCode1);
    }
    locations[Province('Tỉnh/ Thành Phố','9999')] = [District('Quận/ Huyện', '99999')];
    return locations;
  }


}

void main() async {
  // String longitude = '105.804706';
  // String latitude = "21.001357";
  // DioTest.postBranchATMTypeOne(longitude, latitude);
  Map<Province, List<District>> a =  await DioTest.fetchLocation();
  print(a[Province.withRegionName('Hà Nội')]);
  // print(a.length);
}
