import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tago/app.dart';

class HiveHelper {
  final _boxTago = Hive.box('tago');
  final _boxSearch = Hive.box('search');

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('tago');
    await Hive.openBox('search');
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

  /*------------------------------------------------------------------
                 FOR BOX ('SEARCH')
 -------------------------------------------------------------------*/

  // ///     save data
  // Future<void> saveDataSearch(dynamic value) async {
  //   log('savedData: $value');
  //   await _boxSearch.add(value);
  // }

  //      get data
  dynamic getDataSearch({String ? key, dynamic defaultValue}) {
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
