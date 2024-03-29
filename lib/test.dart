import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent BottomSheet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int size = 0;
  bool isKeyboard = false;
  bool isSubmit = false;
  TextEditingController _controller = TextEditingController();
  TextInputType? keyboardType;
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    if (bottomInset > 0) {
      // Bàn phím được mở
      setState(() {
        size = 0;
      });
      print('Keyboard opened');
    } else {
      setState(() {
        if(keyboardType == TextInputType.text){
          size = 345;
        }
        else{
          size = 250;
        }
      });
      // Bàn phím được đóng
      print('Keyboard closed');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ExpandableBottomSheet(
        background: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 100),
              TextField(
                focusNode: _focusNode,
                textInputAction: TextInputAction.go,
                controller: _controller,
                keyboardType: (isKeyboard) ? TextInputType.text : TextInputType.number,
                onSubmitted: (value){
                  keyboardType = (isKeyboard) ? TextInputType.text : TextInputType.number;
                  print("day la $keyboardType");
                },
                decoration: InputDecoration(
                  labelText: 'Nhap du lieu',
                ),
              ),
            ],
          ),
        ),
        expandableContent: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: size.toDouble(),
          color: Colors.grey.shade200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isKeyboard = !isKeyboard;
                          print(isKeyboard);
                        });
                      },
                      child: Icon(FontAwesomeIcons.keyboard, size: 30,),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      // _focusNode.unfocus();
                      // setState(() {
                      //   if(keyboardType == TextInputType.text){
                      //     size = 340;
                      //   }
                      //   else{
                      //     size = 245;
                      //   }
                      // });
                    },
                    child: Icon(FontAwesomeIcons.xmark),
                  )
                ],
              ),
            ],
          ),
        ),
        // persistentHeader: Container(
        //   color: Colors.red,
        // ),
        persistentContentHeight: size.toDouble(),
      ),
    );


  }
}
