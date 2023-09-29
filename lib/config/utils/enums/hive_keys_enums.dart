enum HiveKeys {
  token('token'),
  role('role'),
  addressId('addressId'),
  createOrder('orderId'),
  fromCheckout('fromCheckout'),
  createOrderUrl('url'),
  recentlyViewed('Recently Viewed'),
  search('search');

  const HiveKeys(this.keys);
  final String keys;
}
