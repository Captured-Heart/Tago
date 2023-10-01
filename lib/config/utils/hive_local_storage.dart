import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tago/app.dart';

class HiveHelper {
  final _boxTago = Hive.box('tago');
  final _boxSearch = Hive.box('search');

  final _boxRecentlyViewed = Hive.box<ProductsModel>('recently');

  final _boxCarts = Hive.box<CartModel>('carts');

  static Future<void> init() async {
    Hive.registerAdapter(ProductsModelAdapter());
    Hive.registerAdapter(CartModelAdapter());
    log('enterrr');
    await Hive.initFlutter();
    await Hive.openBox('tago');
    await Hive.openBox('search');

    await Hive.openBox<ProductsModel>('recently');
    await Hive.openBox<CartModel>('carts');
    // Hive.deleteBoxFromDisk('recently');
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

  Future<void> closeBox() async {
    await _boxTago.close();
  }

  int getAddressIndex(String key) {
    log('getData: $key');
    return _boxTago.get(key) ?? 0;
  }

  /*------------------------------------------------------------------
                 FOR BOX ('RECENTLY VIEWED')
 -------------------------------------------------------------------*/
  ValueListenable<Box<ProductsModel>> getRecentlyViewedListenable() {
    return _boxRecentlyViewed.listenable();
  }

// save task
  void saveRecentData(ProductsModel product) async {
    log('the product saved/viewed $product');
    return await _boxRecentlyViewed.put(HiveKeys.recentlyViewed.keys, product);
  }

  ProductsModel? getRecentlyViewed({
    dynamic defaultValue,
  }) {
    return _boxRecentlyViewed.get(
      HiveKeys.recentlyViewed.keys,
    );
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
  ValueListenable<Box<dynamic>> getCartsListenable() {
    return _boxCarts.listenable();
  }

// save task
  void saveCartsToList(CartModel cartProduct) async {
    log('the product saved/viewed $cartProduct');
    return await _boxCarts.put(HiveKeys.recentlyViewed.keys, cartProduct);
  }

  CartModel? getCartsList({
    dynamic defaultValue,
  }) {
    return _boxCarts.get(
      HiveKeys.recentlyViewed.keys,
      defaultValue: defaultValue,
    );
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
