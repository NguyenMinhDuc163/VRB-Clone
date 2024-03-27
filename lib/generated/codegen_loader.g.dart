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
    'exchangeRate2_1': Messages.ExchangeRate2_1En(),
    'exchangeRate2_2': Messages.ExchangeRate2_2En(),
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
    'typeProduct1' : 'Online term deposit',
    'typeProduct2' : 'Online accumulate deposit',
    'formCalc': 'Interest paid the end of the period',
    'month': 'Month',
    'chooseProduct': 'Select product type',
    'chooseMoney': 'Select currency',

    // contact
    'contactTitle': 'Contact',
    'slogan': 'VietNam Russia Joint Venture Bank',
    'headOffice': 'Head office',
    'address': Messages.addressEn,
    'version': 'Version 1.0.10',

    //splash
    'intro1': 'Kết nối thành công',
    'intro2': 'Đồng hành phát triển',

    // location
    'locationTitle': 'ATM and branch locations',
    'province': 'Province/City',
    'district': 'District',
    'nearest': 'Nearest',
    'branch': 'Branch',
    'direct': 'Direct',
    'notFount': 'There are no ATMs/Branch in this area',

    // home
    'find': 'Search function',
    'hi': 'Good morning',
    'service': 'Favorite service',
    'config': 'Custom',
    'block1': 'Domestic money transfers',
    'block2': 'Open a deposit account online',
    'block3': 'Expense management',
    'block4': 'Open an account with a nice number/Phone number/iNick',
    'block5': 'Create loan request',
    'block6': 'Gift sample',
    'account':'Account',
    'list': "List",
    'home' : 'Home',
    'gift' : 'Exchange gifts',
    'notiHome' : 'Notification',
    'setting' : 'Setting',
    'instruct1' : 'Scan QR code to make payment',
    'instruct2' : 'Withdraw cash or transfer money',
    'findCode' : 'Searching for code...',
    'showCode': 'Your code is',
    'createQR': 'Generate QR',
    'downloadQR': 'Download QR image',
    'payInterest': 'Pay Interest',
    'dataEmpty': 'There is currently no data available',
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
    'exchangeRate2_1': Messages.ExchangeRate2_1(),
    'exchangeRate2_2': Messages.ExchangeRate2_2(),
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

    'typeProduct1' : 'Gửi tiền trực tuyến có kì hạn',
    'typeProduct2' : 'Tiền gửi tích luỹ trực tuyến',

    'formCalc': 'Trả lãi cuối kì',

    'locationTitle': 'Vị trí ATM, chi nhánh',
    'province': 'Tỉnh/ Thành phố',
    'district': 'Quận/ Huyện',
    'nearest': 'Gần nhất',
    'branch': 'Chi nhánh',
    'direct': 'Chỉ đường',
    'notFount': 'Không có ATM/ Chi nhánh tại khu vực này',

    'find': 'Tìm kiếm chức năng',
    'hi': 'Chào buổi sáng',
    'service': 'Dịch vụ yêu thích',
    'config': 'Tuỳ chỉnh',
    'block1': 'Chuyển tiền trong nước',
    'block2': 'Mở TK tiền gửi trực tuyến',
    'block3': 'Quản lý chi tiêu',
    'block4': 'Mở TK số đẹp/ SĐT/ iNick',
    'block5': 'Tạo đề nghị vay',
    'block6': 'Mẫu quà tặng',
    'account':'Tài khoản',
    'list': 'danh sách',
    'home' : 'Trang chủ',
    'gift' : 'Đổi quà',
    'notiHome' : 'Thông báo',
    'setting' : 'Cài đặt',
    'instruct1' : 'Quét mã QR để thực hiện thanh toán',
    'instruct2' : 'Rút tiền mặt hoặc chuyển tiền',
    'findCode' : 'Đang tìm kiếm mã code...',
    'showCode': 'Mã code của bạn là',
    'createQR': 'Tạo QR',
    'downloadQR': 'Tải ảnh QR',
    'payInterest': 'Trả lãi cuối kì',
    'dataEmpty': 'Hiện không có dữ liệu',
    'month': 'Tháng',
    'chooseProduct': 'Chọn loại sản phẩm',
    'chooseMoney': 'Chọn loại tiền',

  };
  static  Map<String, Map<String, dynamic>> mapLocales = {
    "en": en,
    "vi": vi
  };
}