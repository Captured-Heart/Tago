import 'package:tago/app.dart';

final valueNotifierProvider = Provider<ValueNotifier<int>>((ref) {
  return ValueNotifier(1);
});

final dateInMetricsNotifierProvider = Provider<ValueNotifier<String>>((ref) {
  return ValueNotifier('Today');
});
