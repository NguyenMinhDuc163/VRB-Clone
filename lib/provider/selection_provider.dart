import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';

class SelectionProvider extends ChangeNotifier{
  int size = 0;
  String typeProduct = LocaleKeys.typeProduct1.tr();
  String typeMoney = "VND";
  int type = 0;
  List<String> listChoose = [LocaleKeys.typeProduct1.tr(), LocaleKeys.typeProduct2.tr()];
  List<String> listMoney = ['USD', 'VND'];
  void changeSize(int newSize, int type){
    size = newSize;
    this.type = type;
    notifyListeners();
  }

  void changeSelect(String value, int type){
    if(type == 0){
      typeProduct = value;
    }else{
      typeMoney = value;
    }
    notifyListeners();
  }
}