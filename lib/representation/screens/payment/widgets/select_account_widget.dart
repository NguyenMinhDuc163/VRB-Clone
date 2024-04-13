import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/provider/outside_bank_payment_provider.dart';

import '../../../../provider/dialog_provider.dart';


class SelectItemWidget extends StatefulWidget {
  const SelectItemWidget({super.key});
  @override
  State<SelectItemWidget> createState() => _SelectItemWidgetState();
}

class _SelectItemWidgetState extends State<SelectItemWidget> {
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
    return Consumer<OutsideBankPaymentProvider>(builder:(context, choose, _){
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
            title: const Text('01234567789 - VND'),
            value:'0123456789 - VND',
            groupValue:
            choose.selectedValue,
            onChanged: (value) async {
             choose.setSelectValue(value!);
             Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
             await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
             Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
             Navigator.pop(context);
            },
          ),
          RadioListTile(
            title: const Text('9999999999999 - VND'),
            value:'9999999999999 - VND',
            groupValue:
            choose.selectedValue,
            onChanged: (value) async {
              choose.setSelectValue(value!);
              Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
              await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
              Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
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
                      Provider.of<OutsideBankPaymentProvider>(context, listen: false).selectedValue,
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