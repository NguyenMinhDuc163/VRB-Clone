import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  TextInputType keyboardType = TextInputType.text;
  FocusNode focusNode = FocusNode();
  bool isCheckHeight = true;
  bool isVisibleButtonSheet = false;

  void changeKeyboardType(BuildContext context) {
    if (keyboardType == TextInputType.text) {
      keyboardType = TextInputType.number;
      isCheckHeight = true;
    } else {
      keyboardType = TextInputType.text;
      isCheckHeight = false;
    }
    focusNode.unfocus();
    Future.delayed(Duration(milliseconds: 1), () {
      FocusScope.of(context).requestFocus(focusNode);
    });
    notifyListeners();
  }

  void setCheckHeight(bool check){
    isCheckHeight = check;
    notifyListeners();
  }

  void setVisibleButtonSheet(bool check){
    isVisibleButtonSheet = check;
    notifyListeners();
  }

  void setkeyboardType(TextInputType type){
    keyboardType = type;
    notifyListeners();
  }
}
