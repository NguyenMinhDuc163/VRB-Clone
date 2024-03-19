class ExchangeRateModel{
  final String currencyCode;
  final String amount;
  final String amountSell;
  final String amounTranfer;

  ExchangeRateModel(
      this.currencyCode, this.amount, this.amountSell, this.amounTranfer);

  @override
  String toString() {
    return 'ExchangeRateModel{currencyCode: $currencyCode, amount: $amount, amountSell: $amountSell, amounTranfer: $amounTranfer}';
  }
}