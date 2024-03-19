// Table(
// border: TableBorder.symmetric(inside: BorderSide.none),
// children: [
// TableRow(
// decoration: BoxDecoration(color: Colors.grey.shade300),
// children: const [
// TableCell(
// child: Center(child: Text('Ngoại tệ')),
// ),
// TableCell(
// child: Center(child: Text('Mua tiền mặt')),
// ),
// TableCell(
// child: Center(child: Text('Mua chuyển khoản')),
// ),
// TableCell(
// child: Center(child: Text('Bán')),
// )
// ],
// ),
// ...rate.exchangeRates.map((rate) => TableRow(
// children: [
// TableCell(
// child: Center(child: Text(rate.currencyCode)),
// ),
// TableCell(
// child: Center(child: Text(rate.amount)),
// ),
// TableCell(
// child: Center(child: Text(rate.amountSell)),
// ),
// TableCell(
// child: Center(child: Text(rate.amounTranfer)),
// ),
// ].map((widget) => Expanded(child: widget)).toList(), // Sử dụng Expanded để mở rộng kích thước của ô
// ))
// ],
// )
