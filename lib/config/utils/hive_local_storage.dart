import 'package:flutter/foundation.dart';
import 'package:tago/app.dart';

class HiveHelper {
  final _boxTago = Hive.box('tago');
  final _boxSearch = Hive.box('search');
  // final _boxRecentlyViewed = Hive.box<List>('recently');
  final _boxRecentlyViewed = Hive.box<ProductsModel>('recently');

  // final _boxCarts = Hive.box<List>('carts');
  final _boxCarts = Hive.box<CartModel>('carts');

  static Future<void> init() async {
    Hive.registerAdapter(CartModelAdapter());
    Hive.registerAdapter(ProductsModelAdapter());

    log('enterrr');
    await Hive.initFlutter();
    await Hive.openBox('tago');
    await Hive.openBox('search');
    // await Hive.openBox<List>('recently');
    await Hive.openBox<ProductsModel>('recently');

    // await Hive.openBox<List>('carts');
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
//                  FOR BOX ('RECENTLY VIEWED')
//  -------------------------------------------------------------------*/
//   ValueListenable<Box<List>> getRecentlyViewedListenable() {
//     return _boxRecentlyViewed.listenable();
//   }

//   saveRecentData(Map<String, dynamic> product) async {
//     log('the product saved/viewed $product');
//     var pro = ProductsModel.fromJson(product);
//     List<ProductsModel> opp = [];
//     opp.add(pro);
//     return await _boxRecentlyViewed.add(opp);
//   }

//   Iterable<List<dynamic>> recentlyBoxValues() {
//     return _boxRecentlyViewed.values;
//   }

//   List<ProductsModel>? getRecentlyViewed({
//     List<ProductsModel>? defaultValue,
//   }) {
//     var opp = _boxRecentlyViewed.get(
//       HiveKeys.recentlyViewed.keys,
//       defaultValue: defaultValue,
//     ) as List<ProductsModel>;

//     return opp;
//   }

//   List<ProductsModel>? getAtRecently(int index) {
//     return _boxRecentlyViewed.getAt(index) as List<ProductsModel>;
//   }

//   // clear box
//   Future<void> clearBoxRecent() async {
//     await _boxRecentlyViewed.clear();
//   }

//   Future<void> closeRecentlyBox() async {
//     return await _boxRecentlyViewed.close();
//   }

  /*------------------------------------------------------------------
                 FOR BOX ('RECENTLY VIEWED')
 -------------------------------------------------------------------*/
  ValueListenable<Box<ProductsModel>> getRecentlyViewedListenable() {
    return _boxRecentlyViewed.listenable();
  }

  saveRecentData(Map<String, dynamic> product) async {
    log('the product saved/viewed $product');
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
    log('the product saved/viewed $cartProduct');
    var cart = CartModel.fromJson(cartProduct);

    return await _boxCarts.add(cart);
  }

  // save task
  saveCartsToListByPutAt(int index, CartModel cartProduct) async {
    log('the product saved/viewed $cartProduct');
    return await _boxCarts.putAt(index, cartProduct);
  }

  deleteAtFromCart(int index) {
    return _boxCarts.deleteAt(index);
  }

  List<CartModel>? getCartsList({
    CartModel ? defaultValue,
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
  dynamic getDataSearch({String? key, dynamic defaultValue}) {
    log('getData: $key');
    return _boxSearch.get(key, defaultValue: defaultValue);
  }

  ValueListenable<Box<dynamic>> getSearchListenable() {
    return _boxSearch.listenable();
  }

  List<dynamic> getAllSearchEntries() {
    return _boxSearch.values.toList();
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

//check if it contains data
  bool containsSearchData(dynamic key) {
    return _boxSearch.containsKey(key);
  }

  Future<dynamic> saveSearchData(String key, List<String> value) async {
    log('save data: $value');

    return await _boxSearch.put(key, value);
  }
}
