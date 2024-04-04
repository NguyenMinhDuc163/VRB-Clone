import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/provider/login_provider.dart';
import 'package:vrb_client/representation/widgets/textfield_keyboard_widget.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  // TextEditingController _controller = TextEditingController();
  // TextEditingController? _controller1 = TextEditingController();
  // FocusNode myFocusNode1 = FocusNode();
  // FocusNode myFocusNode2 = FocusNode();
  // FocusNode myFocusNode3 = FocusNode();
  // FocusNode myFocusNode4 = FocusNode();
  // bool isChange = true;
  // // bool ignore = true;
  // // TextInputType key = TextInputType.number;
  // FocusNode? previousFocusNode;
  //
  //
  // void switchKeyboard() async {
  //   if(myFocusNode1.hasFocus || myFocusNode2.hasFocus){
  //     setState(() {
  //       isChange = !isChange;
  //       if (isChange) {
  //         myFocusNode1.requestFocus();
  //       } else {
  //         myFocusNode2.requestFocus();
  //       }
  //     }
  //     );
  //   }
  //   else{
  //     setState(() {
  //       isChange = !isChange;
  //       if (isChange) {
  //         myFocusNode3.requestFocus();
  //       } else {
  //         myFocusNode4.requestFocus();
  //       }
  //     }
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        // child: Center(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: SingleChildScrollView(
        //       child: Consumer<LoginProvider>(builder: (context, keyboard, child){
        //         return Column(
        //           children: [
        //             ElevatedButton(
        //                 onPressed: keyboard.switchKeyboard,
        //                 child: Text("change")),
        //             SizedBox(
        //               height: 300,
        //               width: double.infinity,
        //             ),
        //             //
        //             //an cai duo igium minh
        //             TapRegion(
        //               onTapOutside: (tap) {
        //                 print("1111111");
        //                 // myFocusNode1.unfocus();
        //                 // myFocusNode2.unfocus();
        //               },
        //               child: Stack(
        //                 children: [
        //                   keyboard.isChange
        //                       ? TextFormField(
        //                       style: Theme.of(context).textTheme.bodyText2,
        //                       controller: keyboard.controller,
        //                       focusNode: keyboard.myFocusNode1,
        //                       textCapitalization:
        //                       TextCapitalization.characters,
        //                       keyboardType: TextInputType.text,
        //                       autofocus: true,
        //                       onChanged: (text) {},
        //                       onTap: (){
        //
        //                       },
        //                       inputFormatters: [
        //                         FilteringTextInputFormatter.allow(
        //                             RegExp('[a-zA-Z0-9]'))
        //                       ],
        //                       decoration:
        //                       const InputDecoration(labelText: '11111'))
        //                       : const SizedBox(),
        //                   keyboard.isChange
        //                       ? const SizedBox()
        //                       : TextFormField(
        //                       style: Theme.of(context).textTheme.bodyText2,
        //                       controller: keyboard.controller,
        //                       focusNode: keyboard.myFocusNode2,
        //                       textCapitalization:
        //                       TextCapitalization.characters,
        //                       keyboardType: TextInputType.number,
        //                       autofocus: true,
        //                       onChanged: (text) {},
        //                       onTap: (){
        //                         setState(() {
        //                           keyboard.isChange = !keyboard.isChange;
        //                           if (keyboard.isChange ) {
        //                             keyboard.myFocusNode1.requestFocus();
        //                           }
        //                           else {
        //                             keyboard.myFocusNode2.requestFocus();
        //                           }
        //                         });
        //
        //                       },
        //                       inputFormatters: [
        //                         FilteringTextInputFormatter.allow(
        //                             RegExp('[a-zA-Z0-9]'))
        //                       ],
        //                       decoration: const InputDecoration(
        //                           labelText: '4444444')),
        //                 ],
        //               ),
        //             ),
        //
        //             Stack(
        //               children: [
        //                 keyboard.isChange
        //                     ? TextFormField(
        //                     style: Theme.of(context).textTheme.bodyText2,
        //                     controller: keyboard.controller1,
        //                     focusNode: keyboard.myFocusNode3,
        //                     textCapitalization:
        //                     TextCapitalization.characters,
        //                     keyboardType: TextInputType.text,
        //                     autofocus: true,
        //                     onChanged: (text) {},
        //                     inputFormatters: [
        //                       FilteringTextInputFormatter.allow(
        //                           RegExp('[a-zA-Z0-9]'))
        //                     ],
        //                     decoration:
        //                     const InputDecoration(labelText: '11111'))
        //                     : const SizedBox(),
        //                 keyboard.isChange
        //                     ? const SizedBox()
        //                     : TextFormField(
        //                     style: Theme.of(context).textTheme.bodyText2,
        //                     controller: keyboard.controller1,
        //                     focusNode: keyboard.myFocusNode4,
        //                     textCapitalization:
        //                     TextCapitalization.characters,
        //                     keyboardType: TextInputType.number,
        //                     autofocus: true,
        //                     onChanged: (text) {
        //
        //                     },
        //                     onTap: (){
        //
        //                       setState(() {
        //                         keyboard.isChange = !keyboard.isChange;
        //                         de3.requestFocus();
        //                         } else {if (keyboard.isChange) {
        //         //                           keyboard.myFocusNo
        //                           keyboard.myFocusNode4.requestFocus();
        //                         }
        //                       });
        //                     },
        //                     inputFormatters: [
        //                       FilteringTextInputFormatter.allow(
        //                           RegExp('[a-zA-Z0-9]'))
        //                     ],
        //                     decoration: const InputDecoration(
        //                         labelText: '4444444')),
        //               ],
        //             ),
        //
        //           ],
        //         );
        //       },),
        //     ),
        //   ),
        // ),
        child: TextFieldKeyBoardWiget(),
      ),
    );
  }
}
