import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/demo_button.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';
import 'package:vrb_client/provider/login_provider.dart';

class TextFieldKeyboardWidget extends StatefulWidget {
  const TextFieldKeyboardWidget(
      {super.key,
      required this.icon,
      required this.hintText,
      required this.controller});
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  @override
  State<TextFieldKeyboardWidget> createState() =>
      _TextFieldKeyboardWidgetState();
}

class _TextFieldKeyboardWidgetState extends State<TextFieldKeyboardWidget> {
  @override
  void dispose() {
    Provider.of<LoginProvider>(context, listen: false)
      .setKeyboardType(TextInputType.text);
    if (widget.hintText == LocaleKeys.userName.tr()) {
      Provider.of<LoginProvider>(context, listen: false)
          .focusNodeName
          .dispose();
    } else {
      Provider.of<LoginProvider>(context, listen: false)
          .focusNodePass
          .dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, keyboard, child) {
      return Row(
        children: [
          Expanded(
            child: TextField(
                textInputAction: TextInputAction.done,
                controller: widget.controller,
                keyboardType: keyboard.keyboardType,
                focusNode: (widget.hintText == LocaleKeys.userName.tr())
                    ? keyboard.focusNodeName
                    : keyboard.focusNodePass,
                onTap: () {
                  keyboard.setType(
                      (widget.hintText == LocaleKeys.userName.tr()) ? 0 : 1);
                  keyboard.setVisibleButtonSheet(true);
                  keyboard.setCheckHeight(true);
                  keyboard.setKeyboardType(TextInputType.number);
                },
                onSubmitted: (val) {
                  keyboard.setVisibleButtonSheet(false);
                  keyboard.setCheckHeight(true);
                  keyboard.setKeyboardType(TextInputType.text);
                },
                decoration: InputDecoration(
                    hintText: widget.hintText, border: InputBorder.none)),
          ),
          IconButton(
            icon: Icon(
              widget.icon,
            ),
            // onPressed: _toggleVisibility,
            onPressed: () {},
          ),
        ],
      );
    });
  }
}
