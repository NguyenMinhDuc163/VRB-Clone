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

  static Future<Map<Province, List<District>>> fetchLocation() async {
    // List<Province> province = await postProviceInfoList();
    // Map<Province, List<District>> locations = {};
    // for(var x in province){
    //   locations[x] = await postDistrict(x.regionCode1);
    // }
    // locations[Province('Tỉnh/ Thành Phố','9999')] = [District('Quận/ Huyện', '99999')];
    // return locations;
    return {};
  }


}

void main() async {
  // String longitude = '105.804706';
  // String latitude = "21.001357";
  // DioTest.postBranchATMTypeOne(longitude, latitude);
  Map<String, Province> a =  await DioTest.postProviceInfoList();
  print(a.length);
  // print(a.length);
}
