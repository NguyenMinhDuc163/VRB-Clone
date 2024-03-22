import 'package:flutter/cupertino.dart';

class SelectionProvider extends ChangeNotifier{
  int size = 0;
  String typeProduct = "Gửi tiền trực tuyến có kì hạn";
  String typeMoney = "VND";
  int type = 0;
  List<String> listChoose = ['Gửi tiền trực tuyến có kì hạn', 'Tiền gửi tích luỹ trực tuyến'];
  List<String> listMoney = ['VND', 'USD'];
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