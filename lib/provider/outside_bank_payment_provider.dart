import 'package:flutter/material.dart';

import '../core/constants/assets_path.dart';

class OutsideBankPaymentProvider extends ChangeNotifier{
  String selectedValue = '0123456789 - VND';
  int selectAccount = 0;
  String chooseBank = 'Chọn ngân hàng thụ hưởng';
  final Map<String, List<String>> bankData = {
    'Vietcombank': ['Vietcombank', 'Ngân hàng TMCP Ngoại thương Việt Nam', AssetPath.logoBank1],
    'Tiên phong bank': ['Tiên phong bank', 'Ngân hàng Thương mại Cổ phần Tiên Phong', AssetPath.logoBank2],
    'VP bank': ['VP bank', 'Ngân Hàng TMCP Việt Nam Thịnh Vượng', AssetPath.logoBank3],
    'Vietinbank': ['Vietinbank', 'Ngân hàng Thương mại Cổ phần Công thương Việt Nam', AssetPath.logoBank4],
    'Tecombank': ['Tecombank', 'Ngân hàng TMCP Ngoại thương Việt Nam', AssetPath.logoBank5],
    'Agribank': ['Agribank', 'Ngân hàng TMCP Kỹ thương Việt Nam', AssetPath.logoBank6],

    'Vietcombank1': ['Vietcombank', 'Ngân hàng TMCP Ngoại thương Việt Nam', AssetPath.logoBank1],
    'Tiên phong bank1': ['Tiên phong bank', 'Ngân hàng Thương mại Cổ phần Tiên Phong', AssetPath.logoBank2],
    'VP bank1': ['VP bank', 'Ngân Hàng TMCP Việt Nam Thịnh Vượng', AssetPath.logoBank3],
    'Vietinbank1': ['Vietinbank', 'Ngân hàng Thương mại Cổ phần Công thương Việt Nam', AssetPath.logoBank4],
    'Tecombank1': ['Tecombank', 'Ngân hàng TMCP Ngoại thương Việt Nam', AssetPath.logoBank5],
    'Agribank1': ['Agribank', 'Ngân hàng TMCP Kỹ thương Việt Nam', AssetPath.logoBank6],
  };

  void setSelectAccount(int selectAccount){
    this.selectAccount = selectAccount;
    notifyListeners();
  }

  void setSelectValue(String value){
    selectedValue = value;
    notifyListeners();
  }

  void setChooseBank(String bankName){
    chooseBank = bankName;
    notifyListeners();
  }
}