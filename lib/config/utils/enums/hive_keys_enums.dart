enum HiveKeys {
  token('token'),
  role('role'),
  // addressId('addressId'),
  createOrder('data'),
  // addressIndex('address index'),
  fromCheckout('fromCheckout'),
  recentlyViewed('Recently Viewed'),
  recentlyId('RecentlyID'),

  cartsKey('carts key'),

  search('search');

  const HiveKeys(this.keys);
  final String keys;
}
