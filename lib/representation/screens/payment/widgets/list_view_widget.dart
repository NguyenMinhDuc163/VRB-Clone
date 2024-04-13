import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/provider/outside_bank_payment_provider.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({super.key});
  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Đặt chiều cao cho container
      child: Consumer<OutsideBankPaymentProvider>(builder: (context, bankProvider, _){
        List<String> nameBank = bankProvider.bankData.keys.toList();
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bankProvider.bankData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2), // Giảm kích thước padding để làm cho các icon gần nhau hơn
              child: IconButton(onPressed: () {
                bankProvider.setChooseBank(nameBank[index]);
              }, icon: Image.asset(
                bankProvider.bankData[nameBank[index]]![2],
                width: 50, // Điều chỉnh chiều rộng của ảnh để phù hợp với UI
              ),

              ),
            );
          },
        );
      },),
    );
  }
}
