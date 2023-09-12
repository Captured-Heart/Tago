enum PaymentMethodsType {
  bankTransfer('bank-transfer'),
  card('card'),
  cash('cash');
  // bank-transfer, card, cash

  const PaymentMethodsType(this.message);
  final String message;
}

enum DeliveryType {
  instant,
  schedule,
}
