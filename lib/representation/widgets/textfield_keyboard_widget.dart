import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldKeyBoardWidget extends StatefulWidget {
  const TextFieldKeyBoardWidget(
      {super.key,
      required this.title,
      required this.icon,
      this.customDecoration, required this.onSubmitted});
  final String title;
  final IconData icon;
  final InputDecoration? customDecoration;
  final ValueChanged<String> onSubmitted;
  @override
  State<TextFieldKeyBoardWidget> createState() =>
      _TextFieldKeyBoardWidgetState();
}

class _TextFieldKeyBoardWidgetState extends State<TextFieldKeyBoardWidget> {
  OverlayEntry? _overlayEntry;
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  bool isChange = true;
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    myFocusNode1.dispose();
    myFocusNode2.dispose();
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }
    super.dispose();
  }
  @override
  void switchKeyboard() async {
    setState(() {
      isChange = !isChange;
      (isChange) ? myFocusNode1.requestFocus() : myFocusNode2.requestFocus();
    });

    if (_overlayEntry != null) {
      _overlayEntry!.remove(); // Xóa OverlayEntry cũ
      showBottomSheet(); // Tạo và hiển thị OverlayEntry mới
    }
  }

  Widget _textFieldWidget(
    FocusNode focusNode,
    TextInputType textInputType,
    VoidCallback? onTap,
  ) {
    InputDecoration decoration = widget.customDecoration ??
        InputDecoration(
          hintText: widget.title,
          border: InputBorder.none,
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: controller,
                    focusNode: focusNode,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: textInputType,
                    onTap: () {
                      onTap!();
                      showBottomSheet();
                    },
                    onChanged: (value){
                      widget.onSubmitted(controller.text);
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))
                    ],
                    decoration: decoration),
              ),
              IconButton(
                icon: Icon(widget.icon),
                // onPressed: _toggleVisibility,
                onPressed: () {},
              ),
            ],
          ),
          (widget.customDecoration == null)
              ? Container(
                  height: 1, // Chiều cao của đường line
                  color: Colors.grey, // Màu của đường line
                )
              : Container(),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }

  void showBottomSheet() {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(builder: (context) {
      double bottomInset = MediaQuery.of(context).viewInsets.bottom;
      return Visibility(child: Positioned(
          bottom: bottomInset > 50 ? bottomInset : bottomInset - 35,
          left: 0,
          right: 0,
          child: Material(
            child: Container(
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
                            switchKeyboard();
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.keyboard_alt_outlined,
                                size: 35,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                height: 35,
                                child: Center(
                                  child: Text(
                                    (isChange) ? 'abc' : '123',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: const Icon(Icons.cancel_outlined),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )));
    });
    overlay.insert(_overlayEntry!);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            isChange
                ? _textFieldWidget(
                    myFocusNode1,
                    TextInputType.text,
                    () {},
                  )
                : const SizedBox(),
            isChange
                ? const SizedBox()
                : _textFieldWidget(myFocusNode2, TextInputType.number, () {
                    setState(() {
                      isChange = !isChange;
                      (isChange)
                          ? myFocusNode1.requestFocus()
                          : myFocusNode2.requestFocus();
                    });
                  })
          ],
        ),
      ],
    );
  }
}
