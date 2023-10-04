enum HiveKeys {
  token('token'),
  role('role'),
  addressId('addressId'),
  addressIndex('address index'),
  createOrder('orderId'),
  fromCheckout('fromCheckout'),
  createOrderUrl('url'),
  recentlyViewed('Recently Viewed'),
  recentlyId('RecentlyID'),

  cartsKey('carts key'),

  search('search');

  const HiveKeys(this.keys);
  final String keys;
}
