import 'package:intl/intl.dart';

class Messages {
  static const String exchangeRate1 =
      "* Các tỷ giá dưới đây có thể thay đổi theo sự biến động của thị trường mà không cần thông báo trước";

  static String getExchangeRate2(DateTime date) {
    return "* Tỷ giá được cập nhất lúc 08:45 ngày ${DateFormat('dd/MM/yyyy').format(date)} và chỉ mang tính chất tham khảo. Quý khách vui lòng "
        "liên hệ các điểm giao dịch của VRB để có tỷ giá ngoại tệ cập nhật mới nhất.";
  }

  static const String notification =
      "Ghi chú Từ ngày 01/01/2018 theo quy định của Ngân hàng Nhà nước cơ sở tính lãi tiền gửi của VRB là 365 ngày/năm.";

  static const String address =
      "Toà nhà 75 Trần Hưng Đạo, phường \nTrần Hưng Đạo quận Hoàn Kiếm, \nHà Nội, Việt Nam";
}
