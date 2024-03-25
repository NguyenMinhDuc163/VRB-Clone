import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/models/user_model.dart';
import 'package:vrb_client/representation/widgets/block_item_widget.dart';

import '../../core/constants/dimension_constants.dart';
import '../widgets/acount_balancea_widget.dart';
import '../widgets/app_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late  bool _showMore = false;
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      const BlockItemWidget(description: 'Chuyển tiền trong nước', iconInner: AssetPath.icoTransfer),
      const BlockItemWidget(description: 'Mở TK tiền gửi trực tuyến', iconInner: AssetPath.icoSave),
      const BlockItemWidget(description: 'Quản lý chi tiêu', iconInner: AssetPath.icoExpense),
      const BlockItemWidget(description: 'Mở TK số đẹp/ SĐT / iNick', iconInner: AssetPath.icoGoodNum),
      const BlockItemWidget(description: 'Tạo đề nghị vay', iconInner: AssetPath.icoLoan),
      const BlockItemWidget(description: 'Mẫu quà tặng', iconInner: AssetPath.icoGift),
      const BlockItemWidget(description: 'Mẫu quà tặng', iconInner: AssetPath.icoGift),
      const BlockItemWidget(description: 'Mẫu quà tặng', iconInner: AssetPath.icoGift),
      const BlockItemWidget(description: 'Mẫu quà tặng', iconInner: AssetPath.icoGift),
    ];

    return Consumer<UserModel>(builder: (context, user, child){
      return AppBarWidget(
        fullName: user.userName,
        avatar: user.avatar,
        child: SingleChildScrollView(
          child: Column(
            children: [
               AccountBalanceWidget(accountNumber: user.accountNumber),
               const SizedBox(
                height: kDefaultPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded( // văn bản đầu tiên chiếm hết không gian có thể và căn trái
                    child: Text(
                      'Dịch vụ yêu thích',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Tuỳ chỉnh',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900),
                    ),
                  )
                ],
              ),
              // TODO Gridview
              // Expanded(
              //   child: GridView.builder(
              //     // itemCount: items.length,
              //     itemCount: _showMore ? items.length : 6,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3, // Số cột trong lưới
              //       crossAxisSpacing: 10, // Khoảng cách giữa các cột
              //       mainAxisSpacing: 10, // Khoảng cách giữa các hàng
              //     ),
              //     itemBuilder: (BuildContext context, int index) {
              //       return InkWell(
              //           onTap: () {
              //             print("da an");
              //           },
              //           child: items[index]);
              //     },
              //   ),
              // ),
              const SizedBox(height: kMediumPadding,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: items[0]), Expanded(child: items[1]), Expanded(child: items[2])
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: items[3]), Expanded(child: items[4]), Expanded(child: items[5])
                ],
              ),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white, // Màu văn bản
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Bo góc
                    ),
                  ),
                  onPressed: (){
                setState(() {
                  _showMore = !_showMore; // Đặt trạng thái hiển thị thêm là true
                });
              }, child: _showMore == false ? const Text("Xem tất cả dịch vụ") :const Text("Thu gon") )
            ],
          ),
        ),
      );
    },);

  }
}
