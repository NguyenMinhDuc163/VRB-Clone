import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

class LoginProvider extends ChangeNotifier {
  bool isPressed = false;
  bool obscureText = true;
  bool islogin = false;
  late final LocalAuthentication auth;
  bool supportState = false;

  void _toggleImage() {
    setIsPressed(!isPressed);
  }

  void _toggleVisibility() {
    obscureText = !obscureText;
  }

  void setIsPressed(bool isPressed){
    this.isPressed = isPressed;
    notifyListeners();
  }

  void setIslogin(bool islogin){
    this.islogin = islogin;
    notifyListeners();
  }
}

