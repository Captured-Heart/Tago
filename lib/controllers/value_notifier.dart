import 'package:tago/app.dart';

final valueNotifierProvider = Provider<ValueNotifier<int>>((ref) {
  return ValueNotifier(1);
});
