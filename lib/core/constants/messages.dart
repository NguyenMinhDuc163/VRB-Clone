import 'package:intl/intl.dart';

class Messages {
  static const String exchangeRate1 =
      "* Các tỷ giá dưới đây có thể thay đổi theo sự biến động của thị trường mà không cần thông báo trước";

  static String ExchangeRate2_1() {
    return "* Tỷ giá được cập nhất lúc 08:45 ngày";
  }
  // loi
  static String ExchangeRate2_2() {
    return "và chỉ mang tính chất tham khảo. Quý khách vui lòng "
        "liên hệ các điểm giao dịch của VRB để có tỷ giá ngoại tệ cập nhật mới nhất.";
  }

  static const String notification =
      "Ghi chú Từ ngày 01/01/2018 theo quy định của Ngân hàng Nhà nước cơ sở tính lãi tiền gửi của VRB là 365 ngày/năm.";

  static const String address =
      "Toà nhà 75 Trần Hưng Đạo,\nphường Trần Hưng Đạo quận \nHoàn Kiếm, Hà Nội, Việt Nam";

// English

  static const String exchangeRate1En =
      "* The exchange rates below are subject to change according to market fluctuations without prior notice";

  static String ExchangeRate2_1En() {
    return "* The exchange rate was last updated at 08:45 on the day";
  }
  static String ExchangeRate2_2En() {
    return "and is for reference only. Please "
        "Contact VRB transaction points for the latest updated foreign exchange rates.";
  }

  static const String notificationEn =
  "Note From January 1, 2018, according to the regulations of the State Bank, VRB's deposit interest basis is 365 days/year.";

  static const String addressEn =
      "Building 75 Tran Hung Dao, \nTran Hung Dao Ward, Hoan Kiem\nDistrict, Hanoi, Vietnam";
}
