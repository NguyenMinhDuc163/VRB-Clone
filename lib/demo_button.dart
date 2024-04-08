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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.25, // Kích thước tối thiểu 25% của chiều cao màn hình
          maxChildSize: 0.6, // Kích thước tối đa 75% của chiều cao màn hình
          initialChildSize: 0.3, // Kích thước ban đầu là 50% của chiều cao màn hình
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              // color: Colors.white,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text('Item $index'));
                },
              ),
            );
          },
        );
      },
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable Scrollable Sheet Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Show Bottom Sheet'),
          onPressed: () => _showBottomSheet(context),
        ),
      ),
    );
  }
}
