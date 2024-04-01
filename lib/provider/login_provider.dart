import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  TextInputType keyboardType = TextInputType.number;
  // FocusNode focusNode = FocusNode();
  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodePass = FocusNode();
  bool isCheckHeight = true;
  bool isVisibleButtonSheet = false;
  int type = 0;
  void changeKeyboardType(BuildContext context) {
    if (keyboardType == TextInputType.text) {
      keyboardType = TextInputType.number;
      isCheckHeight = true;
    } else {
      keyboardType = TextInputType.text;
      isCheckHeight = false;
    }
    (type == 0) ? focusNodeName.unfocus() : focusNodePass.unfocus();
    Future.delayed(const Duration(milliseconds: 1), () {
      (type == 0)
          ? FocusScope.of(context).requestFocus(focusNodeName)
          : FocusScope.of(context).requestFocus(focusNodePass);
    });
    print("------------provider : $keyboardType");
    notifyListeners();
  }

  void setCheckHeight(bool check) {
    isCheckHeight = check;
    notifyListeners();
  }

  void setVisibleButtonSheet(bool check) {
    isVisibleButtonSheet = check;
    notifyListeners();
  }

  void setKeyboardType(TextInputType type) {
    keyboardType = type;
    notifyListeners();
  }

  void setType(int type) {
    this.type = type;
    notifyListeners();
  }
}
