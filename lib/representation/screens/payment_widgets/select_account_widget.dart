import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrb_client/core/constants/assets_path.dart';

class SelectItemWidget extends StatefulWidget {
  const SelectItemWidget({super.key, required this.title});
  final String title;
  @override
  State<SelectItemWidget> createState() => _SelectItemWidgetState();
}

class _SelectItemWidgetState extends State<SelectItemWidget> {
  String _selectedValue = '01234567789';
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.25, // Kích thước tối thiểu 25% của chiều cao màn hình
          maxChildSize: 0.7, // Kích thước tối đa 75% của chiều cao màn hình
          initialChildSize: 0.5, // Kích thước ban đầu là 50% của chiều cao màn hình
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: _buildChoseItem(context),
            );
          },
        );
      },
    );

  }

  Widget _buildChoseItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chọn số tài khoản nguồn',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(FontAwesomeIcons.xmark))
            ],
          ),
        ),
        RadioListTile(
          title: Text('01234567789'),
          value:'01234567789',
          groupValue:
          _selectedValue,
          onChanged: (value) async {
            setState(() {
              _selectedValue = value!;
            });
          },
        ),
        RadioListTile(
          title: Text('999999999999999'),
          value:'999999999999999',
          groupValue:
          _selectedValue,
          onChanged: (value) async {
            setState(() {
              _selectedValue = value!;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        InkWell(
          onTap: () {
            _showBottomSheet(context);
          },
          child: SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(fontSize: 16),
                    )),
                Image.asset(AssetPath.icoDownBold),
              ],
            ),
          ),
        ),
        Container(height: 1, color: Colors.grey.shade400,)
      ],
    );
  }
}