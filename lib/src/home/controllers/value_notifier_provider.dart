import 'package:tago/app.dart';

final valueNotifierProvider =
    Provider.family<ValueNotifier<int>, int>((ref, value) {
  return ValueNotifier(value);
});

final dateInMetricsNotifierProvider = Provider<ValueNotifier<String>>((ref) {
  return ValueNotifier('Today');
});
