import 'package:flutter/foundation.dart';
import 'package:tago/app.dart';

class HiveHelper {
  final _boxTago = Hive.box('tago');
  final _boxSearch = Hive.box<ProductsModel>('search');
  final _boxOrdersList = Hive.box<OrderListModel>('orders_list');
  final _boxRecentlyViewed = Hive.box<ProductsModel>('recently');

  // final _boxCarts = Hive.box<List>('carts');
  final _boxCarts = Hive.box<CartModel>('carts');

  static Future<void> init() async {
    Hive.registerAdapter(CartModelAdapter());
    Hive.registerAdapter(ProductsModelAdapter());
    Hive.registerAdapter(OrderListModelAdapter());
    Hive.registerAdapter(AddressModelAdapter());
    Hive.registerAdapter(FulfillmentHubModelAdapter());
    Hive.registerAdapter(AddressSearchResponseAdapter());
    Hive.registerAdapter(AccountModelAdapter());
    Hive.registerAdapter(OrderItemModelAdapter());

    log('enterrr');
    await Hive.initFlutter();
    await Hive.openBox('tago');
    await Hive.openBox<ProductsModel>('search');
    await Hive.openBox<OrderListModel>('orders_list');
    await Hive.openBox<ProductsModel>('recently');
    await Hive.openBox<CartModel>('carts');
  }

/*------------------------------------------------------------------
                 FOR BOX('TAGO')
 -------------------------------------------------------------------*/

  Future<void> saveData(String key, dynamic value) async {
    log('savedData: $value');
    await _boxTago.put(key, value);
  }

  dynamic getData(String key) {
    log('getData: $key');
    return _boxTago.get(key);
  }

  Future<void> deleteData(String key) async {
    log('deletedDataKey: $key');

    await _boxTago.delete(key);
  }

  List<dynamic> getAllKeys() {
    log(_boxTago.keys.map((e) => e).toString());
    return _boxTago.keys.toList();
  }

  Future<void> closeTagoBox() async {
    await _boxTago.close();
  }

  int getAddressIndex(String key) {
    log('getData: $key');
    return _boxTago.get(key) ?? 0;
  }

//   /*------------------------------------------------------------------
//                  FOR BOX ('ORDERS LIST VIEWED')
//  -------------------------------------------------------------------*/
  ValueListenable<Box<OrderListModel>> getOrdersListListenable() {
    return _boxOrdersList.listenable();
  }

  Iterable<OrderListModel> orderListBoxValues() {
    return _boxOrdersList.values;
  }

  Future<void> clearBoxOrderLists() async {
    // log(' i cleared the hive box for orders');
    await _boxOrdersList.clear();
  }

  saveAllOrders(List<OrderListModel> orderList) async {
    await _boxOrdersList.clear();
    for (var element in orderList) {
      await _boxOrdersList.put(element.id, element);
    }
  }

  updateSingleOrder(OrderListModel order) async {
    await _boxOrdersList.put(order.id, order);
  }

  saveOrderLists(OrderListModel orderList) {
    // log('from Hive: $orderList');
    var totalOrderLists = (HiveHelper().orderListBoxValues())
        .map(
          (e) => OrderListModel(
            address: e.address,
            fulfillmentHub: e.fulfillmentHub,
            user: e.user,
            rider: e.rider,
            orderItems: e.orderItems,
          ),
        )
        .toList();

    // log('this is from the total orders: $totalOrderLists');

    if (totalOrderLists.map((e) => e.id).toList().contains(orderList.id) ==
        false) {
      _boxOrdersList.add(orderList);
    } else {
      log('this is from the total orders: ${totalOrderLists.map((e) => e.id).toList()}');
    }
  }

  deleteAtFromOrderLists(int index) {
    return _boxOrdersList.deleteAt(index);
  }

  /*------------------------------------------------------------------
                 FOR BOX ('RECENTLY VIEWED')
 -------------------------------------------------------------------*/
  ValueListenable<Box<ProductsModel>> getRecentlyViewedListenable() {
    return _boxRecentlyViewed.listenable();
  }

  saveRecentData(Map<String, dynamic> product) async {
    // log('the product saved/viewed $product');
    var pro = ProductsModel.fromJson(product);
    List<ProductsModel> opp = [];
    opp.add(pro);
    return await _boxRecentlyViewed.add(pro);
  }

  Iterable<ProductsModel> recentlyBoxValues() {
    return _boxRecentlyViewed.values;
  }

  List<ProductsModel>? getRecentlyViewed({
    ProductsModel? defaultValue,
  }) {
    var opp = _boxRecentlyViewed.get(
      HiveKeys.recentlyViewed.keys,
      defaultValue: defaultValue,
    ) as List<ProductsModel>;

    return opp;
  }

  List<ProductsModel>? getAtRecently(int index) {
    return _boxRecentlyViewed.getAt(index) as List<ProductsModel>;
  }

  // clear box
  Future<void> clearBoxRecent() async {
    await _boxRecentlyViewed.clear();
  }

  Future<void> closeRecentlyBox() async {
    return await _boxRecentlyViewed.close();
  }

  /*------------------------------------------------------------------
                 FOR BOX ('CARTS SECTION')
 -------------------------------------------------------------------*/
  ValueListenable<Box<CartModel>> getCartsListenable() {
    return _boxCarts.listenable();
  }

  Iterable<CartModel> cartsBoxValues() {
    return _boxCarts.values;
  }

// save task
  saveCartsToList(Map<String, dynamic> cartProduct) async {
    // log('the product saved/viewed $cartProduct');
    var cart = CartModel.fromJson(cartProduct);

    return await _boxCarts.add(cart);
  }

  // save task
  saveCartsToListByPutAt(int index, CartModel cartProduct) async {
    // log('the product saved/viewed $cartProduct');
    return await _boxCarts.putAt(index, cartProduct);
  }

  deleteAtFromCart(int index) {
    return _boxCarts.deleteAt(index);
  }

  List<CartModel>? getCartsList({
    CartModel? defaultValue,
  }) {
    var opp = _boxCarts.get(
      HiveKeys.cartsKey.keys,
      defaultValue: defaultValue,
    ) as List<CartModel>;
    return opp;
  }

  Future<void> closeCartsBox() async {
    return await _boxCarts.close();
  }

  List<CartModel>? getAtCarts(int index) {
    return _boxCarts.getAt(index) as List<CartModel>;
  }

  // clear box
  Future<void> clearCartList() async {
    await _boxCarts.clear();
  }

  /*------------------------------------------------------------------
                 FOR BOX ('SEARCH')
 -------------------------------------------------------------------*/

  //      get data
  List<ProductsModel> getDataSearch({ProductsModel? defaultValue}) {
    // log('getData: $key');
    var data = _boxSearch.get(HiveKeys.search.keys, defaultValue: defaultValue)
        as List<ProductsModel>;
    return data;
  }

  ValueListenable<Box<ProductsModel>> getSearchListenable() {
    return _boxSearch.listenable();
  }

  Iterable<ProductsModel> getAllSearchEntries() {
    return _boxSearch.values;
  }

  // close box
  Future<void> closeBoxSearch() async {
    await _boxSearch.close();
  }

  // clear box
  Future<void> clearBoxSearch() async {
    await _boxSearch.clear();
  }

  // delete at index
  Future<void> deleteSearchAtIndex(int index) async {
    await _boxSearch.deleteAt(index);
  }

// //check if it contains data
//   bool containsSearchData(dynamic key) {
//     return _boxSearch.containsKey(key);
//   }

  Future<dynamic> saveSearchData(Map<String, dynamic> searchProduct) async {
    log('save data: $searchProduct');
    var search = ProductsModel.fromJson(searchProduct);

    return await _boxSearch.add(search);
  }
}
