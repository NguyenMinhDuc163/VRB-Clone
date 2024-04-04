import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';

import '../../core/constants/dimension_constants.dart';
import '../../provider/login_provider.dart';

class TextFieldKeyBoardWiget extends StatefulWidget {
  const TextFieldKeyBoardWiget({super.key});

  @override
  State<TextFieldKeyBoardWiget> createState() => _TextFieldKeyBoardWigetState();
}


class _TextFieldKeyBoardWigetState extends State<TextFieldKeyBoardWiget> {

  Widget _textFieldWidget(String title, TextEditingController controller, FocusNode focusNode,
      TextInputType textInputType, VoidCallback? onTap, IconData icon){
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText2,
                    controller: controller,
                    focusNode: focusNode,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: textInputType,
                    // autofocus: true,
                    onChanged: (text) {},
                    onTap: onTap,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp('[a-zA-Z0-9]'))
                    ],
                    // decoration: InputDecoration(
                    //     labelText: title));
                decoration: InputDecoration(
                    hintText: title, border: InputBorder.none)),
              ),
              IconButton(
                icon: Icon(
                  icon
                ),
                // onPressed: _toggleVisibility,
                onPressed: () {},
              ),
            ],
          ),
          Container(
            height: 1, // Chiều cao của đường line
            color: Colors.grey, // Màu của đường line
          ),
          SizedBox(height: kDefaultPadding,)
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, keyboard, child) {
      return Column(
        children: [
          Stack(
            children: [
              keyboard.isChange
                  ?
              _textFieldWidget(LocaleKeys.userName.tr(), keyboard.controller, keyboard.myFocusNode1, TextInputType.text, () { },
                  FontAwesomeIcons.user
              )
                  : const SizedBox(),
              keyboard.isChange
                  ? const SizedBox()
              :_textFieldWidget(LocaleKeys.userName.tr(), keyboard.controller, keyboard.myFocusNode2, TextInputType.number, () {
                setState(() {
                  keyboard.isChange = !keyboard.isChange;
                  if (keyboard.isChange) {
                    keyboard.myFocusNode1.requestFocus();
                  } else {
                    keyboard.myFocusNode2.requestFocus();
                  }
                });
              }, FontAwesomeIcons.user)
            ],
          ),
          Stack(
            children: [
              keyboard.isChange
              ? _textFieldWidget(LocaleKeys.passWord.tr(), keyboard.controller1, keyboard.myFocusNode3, TextInputType.text, () { },
                  Icons.visibility)
                  : const SizedBox(),
              keyboard.isChange
                  ? const SizedBox()
              : _textFieldWidget(LocaleKeys.passWord.tr(), keyboard.controller1, keyboard.myFocusNode4, TextInputType.number,() {
                setState(() {
                  keyboard.isChange = !keyboard.isChange;
                  if (keyboard.isChange) {
                    keyboard.myFocusNode3.requestFocus();
                  } else {
                    keyboard.myFocusNode4.requestFocus();
                  }
                });
              }, Icons.visibility)
            ],
          ),
        ],
      );
    });
  }
}
