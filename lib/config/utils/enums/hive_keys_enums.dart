enum HiveKeys {
  token('token'),
  role('role'),
  addressId('addressId'),
  createOrder('orderId'),
  fromCheckout('fromCheckout'),
  search('search');

  const HiveKeys(this.keys);
  final String keys;
}
