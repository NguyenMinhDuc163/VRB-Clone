import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationRequest {
  static const String baseURL = 'http://uat.seatechit.com.vn/retail-mobile/api';

  static Future<Map<String, dynamic>> getProvinceInfo(String latitude, String longitude) async {
    const String url = '$baseURL/inquiryProviceInfoList';
    final Map<String, String> payload = {
      "longitude": longitude,
      "latitude": latitude,
    };
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(payload),
    );
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getDistrictInfo(String latitude, String longitude, String regionCode) async {
    final String url = '$baseURL/inquiryProviceInfoList/district';
    final Map<String, String> payload = {
      "longitude": longitude,
      "latitude": latitude,
      "regionCode1": regionCode,
    };
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(payload),
    );
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getATMInfo(String latitude, String longitude, String regionCode, String districtCode) async {
    final String url = '$baseURL/inquiryProviceInfoList/branhATM';
    final Map<String, String> payload = {
      "longitude": longitude,
      "latitude": latitude,
      "regionCode1": regionCode,
      "districtCode": districtCode,
    };
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(payload),
    );
    return json.decode(response.body);
  }
}

void main() async {
  // Test with sample coordinates
  String latitude = "21.001357";
  String longitude = "105.804706";

  // Get province info
  Map<String, dynamic> provinceInfo = await LocationRequest.getProvinceInfo(latitude, longitude);
  print("Province Info: $provinceInfo\n");


  // Get district info
  String regionCode = provinceInfo['regionCode1']; // Lấy regionCode từ phản hồi của province info
  Map<String, dynamic> districtInfo = await LocationRequest.getDistrictInfo(latitude, longitude, regionCode);
  print("District Info: $districtInfo\n");
  //
  // // Get ATM info
  // String districtCode = districtInfo['districtCode']; // Lấy districtCode từ phản hồi của district info
  // Map<String, dynamic> atmInfo = await LocationRequest.getATMInfo(latitude, longitude, regionCode, districtCode);
  // print("ATM Info: $atmInfo\n");
}
