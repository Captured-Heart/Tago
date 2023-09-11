import 'package:tago/app.dart';

final getAvailabileDateProvider =
    FutureProvider.autoDispose<List<AvailabilityModel>>((ref) async {
  return getAvailableDatesMethod();
});

//
final getAvailabileTimesProvider = FutureProvider.family
    .autoDispose<List<TimesModel>, int>((ref, index) async {
  return getAvailableTimesMethod(index);
});

//
final getDeliveryFeeProvider = FutureProvider.family
    .autoDispose<String, List<dynamic>>((ref, index) async {
  return getDeliveryFeeMethod(
      addressId: index[0].toString(), totalAmount: index[1].toString());
});
