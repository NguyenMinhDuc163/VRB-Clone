import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/demo_button.dart';
import 'package:vrb_client/provider/login_provider.dart';

class TextFieldKeyboardWidget extends StatefulWidget {
  const TextFieldKeyboardWidget({super.key});

  @override
  State<TextFieldKeyboardWidget> createState() => _TextFieldKeyboardWidgetState();
}

class _TextFieldKeyboardWidgetState extends State<TextFieldKeyboardWidget> {
  @override
  void dispose() {
   // focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, keyboard, child){
      return Column(
        children: [
          TextField(
            keyboardType: keyboard.keyboardType,
            focusNode: keyboard.focusNode,
            onTap: () {
              keyboard.setVisibleButtonSheet(true);
            },
            onSubmitted: (val){
              keyboard.setVisibleButtonSheet(false);
              keyboard.setCheckHeight(true);
              keyboard.setkeyboardType(TextInputType.text);
            },
          ),

        ],
      );
    });
  }

}
