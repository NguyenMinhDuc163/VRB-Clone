import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';
import 'package:vrb_client/provider/outside_bank_payment_provider.dart';


class ListBankHistoryWidget extends StatefulWidget {
  const ListBankHistoryWidget({super.key});

  @override
  State<ListBankHistoryWidget> createState() => _ListBankHistoryWidgetState();
}

class _ListBankHistoryWidgetState extends State<ListBankHistoryWidget> {

  Widget _buildHistoryExchange(String image, String name, String accountNum, String bankName){
    return Row(
      children: [
        SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(image)),
        SizedBox(width: kDefaultPadding,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            SizedBox(height: 3,),
            Text(accountNum),
            SizedBox(height: 3,),
            Text(bankName, style: TextStyle(color: Colors.grey.shade500),),
          ],
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Đặt chiều cao cho container
      child: Consumer<OutsideBankPaymentProvider>(builder: (context, bankProvider, _){
        List<String> nameBank = bankProvider.bankData.keys.toList();
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: bankProvider.bankData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2), // Giảm kích thước padding để làm cho các icon gần nhau hơn
              child: Column(
                children: [
                  InkWell(
                      onTap: (){
                        bankProvider.setChooseBank(nameBank[index]);
                      },
                      child: _buildHistoryExchange(bankProvider.bankData[nameBank[index]]![2], 'Nguyen Van A', '123456789123', 'VRB')),
                  SizedBox(height: kDefaultPadding,),
                ],
              ),
            );
          },
        );
      },),
    );
  }
}
