// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Content(),
//     );
//   }
// }
//
// class Content extends StatefulWidget {
//   const Content({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   ContentState createState() => ContentState();
// }
//
// class _ContentState extends State<Content> {
//   TextEditingController _controller = TextEditingController();
//   TextEditingController? _controller1 = TextEditingController();
//   FocusNode myFocusNode1 = FocusNode();
//   FocusNode myFocusNode2 = FocusNode();
//   FocusNode myFocusNode3 = FocusNode();
//   bool isChange = true;
//   bool ignore = true;
//   TextInputType key = TextInputType.number;
//
//   @override
//   void initState() {
//     super.initState();
//     myFocusNode1.addListener(() {
//       if (myFocusNode1.hasFocus) {
//         // ignore = true;
//         // setState(() {
//         //
//         // });
//         // _controller1 = null;
//       }
//     });
//     myFocusNode2.addListener(() {
//       if (myFocusNode2.hasFocus) {
//         // ignore = true;
//         // setState(() {
//         //
//         // });
//         //_controller1 = null;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: GestureDetector(
//         onTap: (){
//           FocusScope.of(context).requestFocus(FocusNode());
//         },
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 300,
//                     width: double.infinity,
//                   ),
//                   //
//                   //an cai duo igium minh
//                   TapRegion(
//                     onTapOutside: (tap) {
//                       print("1111111");
//                       // myFocusNode1.unfocus();
//                       // myFocusNode2.unfocus();
//                     },
//
//                     child: Stack(
//                       children: [
//                         isChange
//                             ? TextFormField(
//                             style: Theme.of(context).textTheme.bodyText2,
//                             controller: _controller,
//                             focusNode: myFocusNode1,
//                             textCapitalization: TextCapitalization.characters,
//                             keyboardType: TextInputType.text,
//                             autofocus: true,
//                             onChanged: (text) {},
//                             inputFormatters: [
//                               FilteringTextInputFormatter.allow(
//                                   RegExp('[a-zA-Z0-9]'))
//                             ],
//                             decoration:
//                             const InputDecoration(labelText: '11111'))
//                             : const SizedBox(),
//                         isChange
//                             ? const SizedBox()
//                             : TextFormField(
//                             style: Theme.of(context).textTheme.bodyText2,
//                             controller: _controller,
//                             focusNode: myFocusNode2,
//                             textCapitalization: TextCapitalization.characters,
//                             keyboardType: TextInputType.number,
//                             autofocus: true,
//                             onChanged: (text) {},
//                             inputFormatters: [
//                               FilteringTextInputFormatter.allow(
//                                   RegExp('[a-zA-Z0-9]'))
//                             ],
//                             decoration:
//                             const InputDecoration(labelText: '4444444')),
//                       ],
//                     ),
//                   ),
//
//                   TextFormField(
//                       focusNode: myFocusNode3,
//                       autofocus: true,
//                       controller: _controller1,
//                       decoration: const InputDecoration(labelText: 'focus 3')),
//
//                   SizedBox(
//                     height: 100,
//                   ),
//
//                   ElevatedButton(
//                       onPressed: () async {
//                         setState(() {
//                           isChange = !isChange;
//                           if (isChange) {
//                             myFocusNode1.requestFocus();
//                           } else {
//                             myFocusNode2.requestFocus();
//                           }
//                         });
//                       },
//                       child: Text("change"))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
