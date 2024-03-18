import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vrb_client/core/constants/assets_path.dart';

class UserModel extends ChangeNotifier {
  String _userName = 'Nguyen Van A';
  String _accountNumber = "0123456789";
  String _avatar = AssetPath.avatar; // Đường dẫn ảnh mặc định

  String get userName => _userName;
  String get accountNumber => _accountNumber;
  String get avatar => _avatar;

  void changeAvatar(String newAvatarPath) {
    _avatar = newAvatarPath;
    notifyListeners(); // Thông báo cho các người nghe về sự thay đổi
  }

  Future<void> pickAndSetAvatar(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Cập nhật ảnh đại diện nếu người dùng đã chọn ảnh
      changeAvatar(pickedFile.path);
    } else {
      // Xử lý nếu người dùng không chọn ảnh
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không có ảnh được chọn.')),
      );
    }
  }
}
