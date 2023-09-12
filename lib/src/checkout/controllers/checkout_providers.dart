import 'package:tago/app.dart';

final getAvailabileDateProvider = FutureProvider.autoDispose<List<AvailabilityModel>>((ref) async {
  return getAvailableDatesMethod();
});

//
final getAvailabileTimesProvider =
    FutureProvider.family.autoDispose<List<TimesModel>, int>((ref, index) async {
  return getAvailableTimesMethod(index);
});

//
final getDeliveryFeeProvider = FutureProvider.autoDispose.family<String, int>((ref, amount) async {
  final addressId = ref.watch(getAccountInfoProvider).value?.id;
  return getDeliveryFeeMethod(addressId: addressId ?? 'dd', totalAmount: amount.toString());
});

//
final getVoucherStreamProvider =
    StreamProvider.autoDispose.family<VoucherModel, String>((ref, code) async* {
  yield* getVoucherMethod(code: code);
});
