extension PriceFormat on double {
  String get euro => '€${toStringAsFixed(2)}';
}
