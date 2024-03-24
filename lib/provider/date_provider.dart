import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'dialog_provider.dart';

class DateProvider extends ChangeNotifier{
  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
    await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
    Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
    if (picked != null){
      selectedDate = picked;
      notifyListeners();
    }

  }
}