import 'package:hive_flutter/hive_flutter.dart';
import 'package:tago/app.dart';

class HiveHelper {
  final _box = Hive.box('tago');

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('tago');
    // _box = Hive.box('tago');
  }

  Future<void> saveData(String key, dynamic value) async {
    log('savedData: $value');
    await _box.put(key, value);
  }

  dynamic getData(String key) {
    return _box.get(key);
  }

  Future<void> deleteData(String key) async {
    log('deletedDataKey: $key');

    await _box.delete(key);
  }
  Future<void> deleteDataAt(int index) async {
    log('deletedDataIndex: $index');

    await _box.deleteAt(index);
  }

  List<dynamic> getAllKeys() {
    return _box.keys.toList();
  }

  Future<void> closeBox() async {
    await _box.close();
  }
}
