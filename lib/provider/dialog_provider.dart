import 'package:flutter/material.dart';

class DialogProvider extends ChangeNotifier{
  bool _loading = false;

  void showLoadingDialog(BuildContext context) {
    _loading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    notifyListeners();
  }
  void hideLoadingDialog(BuildContext context) {
    _loading = false;
    Navigator.of(context).pop();
    notifyListeners();
  }
}