import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  FocusNode myFocusNode3 = FocusNode();
  FocusNode myFocusNode4 = FocusNode();
  bool isChange = true;
  bool isVisibleButtonSheet = false;
  // bool ignore = true;
  // TextInputType key = TextInputType.number;
  FocusNode? previousFocusNode;

  void switchKeyboard() async {
    if(myFocusNode1.hasFocus || myFocusNode2.hasFocus){
      isChange = !isChange;
      if (isChange) {
        myFocusNode1.requestFocus();
      } else {
        myFocusNode2.requestFocus();
      }
    }
    else{
      isChange = !isChange;
      if (isChange) {
        myFocusNode3.requestFocus();
      } else {
        myFocusNode4.requestFocus();
      }
    }
    notifyListeners();
  }

  void setVisibleButtonSheet(bool check) {
    isVisibleButtonSheet = check;
    notifyListeners();
  }
}

