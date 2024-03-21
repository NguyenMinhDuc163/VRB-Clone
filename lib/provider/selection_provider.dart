import 'package:flutter/cupertino.dart';

class SelectionProvider extends ChangeNotifier{
  int size = 0;

  void changeSize(int newSize){
    size = newSize;
    notifyListeners();
  }
}