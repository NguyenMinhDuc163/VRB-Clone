import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';

import '../../core/constants/dimension_constants.dart';
import '../../provider/login_provider.dart';

class TextFieldKeyBoardWidget extends StatefulWidget {
  const TextFieldKeyBoardWidget({super.key});

  @override
  State<TextFieldKeyBoardWidget> createState() => _TextFieldKeyBoardWidgetState();
}


class _TextFieldKeyBoardWidgetState extends State<TextFieldKeyBoardWidget> {
  OverlayEntry?_overlayEntry;

  Widget _textFieldWidget(String title, TextEditingController controller, FocusNode focusNode,
      TextInputType textInputType, VoidCallback? onTap, IconData icon){
    return Container(
      padding: const EdgeInsets.symmetric(
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
                    onChanged: (text) {},
                    onTap: (){
                      onTap!();
                      showBottomSheet();
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp('[a-zA-Z0-9]'))
                    ],
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
          const SizedBox(height: kDefaultPadding,)
        ],
      ),
    );
  }

  void showBottomSheet(){
      final overlay= Overlay.of(context);
      _overlayEntry = OverlayEntry(builder: (context) {
        double bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return Positioned(
            bottom: bottomInset > 50 ? bottomInset: bottomInset - 35,
            left: 0,
            right: 0,

            child:Material(
              child: Consumer<LoginProvider>(builder: (context, keyboard, child) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                keyboard.switchKeyboard();
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.keyboard,
                                    size: 35,
                                  ),
                                  const SizedBox(
                                    width: kDefaultPadding,
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: Center(
                                      child: Text(
                                        (keyboard.isChange)
                                            ? 'abc'
                                            : '123',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // keyboard.focusNode.unfocus();
                              FocusScope.of(context).requestFocus(FocusNode());
                              keyboard.setVisibleButtonSheet(false);
                            },
                            child: const Icon(FontAwesomeIcons.xmark),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ));
      }

      );
      overlay.insert(_overlayEntry!);
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
