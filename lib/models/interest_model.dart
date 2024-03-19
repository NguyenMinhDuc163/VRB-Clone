class InterestModel{
  String productCode;
  String termSTR;
  String rate;

  InterestModel(this.rate, this.productCode, this.termSTR, );

  @override
  String toString() {
    return 'InterestModel{productCode: $productCode, termSTR: $termSTR, rate: $rate}';
  }
}