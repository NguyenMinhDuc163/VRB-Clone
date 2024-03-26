import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;
import '../core/constants/messages.dart';

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static  Map<String, dynamic> en = {
    'userName': 'User Name',
    'passWord': 'Enter password',
    'register': 'Register now',
    'forgot': 'Forgot password?',
    'signIn': 'Sign in?',
    'signInAnother': 'Sign in with another account',
    'exchangeRate': 'exchange rate',
    'interestRate': 'Interest rate',
    'network': 'Network',
    'contact': 'Contact',

    //exchange
    'exchangeTile': 'Exchange rate',
    'exchangeRate1': Messages.exchangeRate1En,
    'exchangeRate2': Messages.ExchangeRate2En(),
    'time': 'Time',
    'exchangeVsVND': 'Foreign currency exchange rate compared to VND',
    'foreign': 'Foreign Currency',
    'buy': 'Buy Cash',
    'buyByTrans': 'Buy by transsfer',
    'sell': 'Sell',

    //interest
    'interestTitle': 'Interest rate',
    'individualRate': 'Interest rates for individual customers',
    'notification': Messages.notificationEn,
    'productType': 'Type of products',
    'currencyType': 'Type of currency',
    'calc': 'From of interest calculation',
    'tenor': 'Tenor',
    'rate': 'Interest rate (%/Year)',

    // contact
    'contactTitle': 'Contact',
    'slogan': 'VietNam Russia Joint Venture Bank',
    'headOffice': 'Head office',
    'address': Messages.addressEn,
    'version': 'Version 1.0.10',

    //splash
    'intro1': 'Kết nối thành công',
    'intro2': 'Đồng hành phát triển',
  };
  static  Map<String, dynamic> vi = {
    'userName': 'Tên Đăng Nhập',
    'passWord': 'Nhập mật khẩu',
    'register': 'Quên mật khẩu',
    'forgot': 'Đăng kí mở tài khoản?',
    'signIn': 'Đăng nhập',
    'signInAnother': 'Đăng nhập bằng tài khoản khác',
    'exchangeRate': 'Tỉ giá',
    'interestRate': 'Lãi xuất',
    'network': 'Mạng lưới',
    'contact': 'Liên hệ',
    'exchangeVsVND': 'Tỷ giá ngoại tệ so với VND',

    'exchangeTile': 'Tỉ giá ngoại tệ',
    'exchangeRate1': Messages.exchangeRate1,
    'exchangeRate2': Messages.ExchangeRate2(),
    'time': 'Thời gian',

    'foreign': 'Ngoại tệ',
    'buy': 'Mua tiền mặt',
    'buyByTrans': 'Mua chuyển khoản',
    'sell': 'Bán',

    'interestTitle': 'Lãi xuất',
    'individualRate': 'Lãi xuất dành cho khách hàng cá nhân',
    'notification': Messages.notification,
    'productType': 'Loại sản phẩm',
    'currencyType': 'loại tiền',
    'calc': 'Hình thức trả lãi',
    'tenor': 'Kì hạn',
    'rate': 'Lãi xuất (%/Năm)',

    'contactTitle': 'Liên hệ',
    'slogan': 'Ngân hàng Liên doanh Việt - Nga',
    'headOffice': 'Trụ sở chính',
    'address': Messages.address,
    'version': 'Phiên bản 1.0.10',

    'intro1': 'Connected successfully',
    'intro2': 'Cultivating Development',
  };
  static  Map<String, Map<String, dynamic>> mapLocales = {
    "en": en,
    "vi": vi
  };
}