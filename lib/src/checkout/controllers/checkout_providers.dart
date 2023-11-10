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
final getDeliveryFeeProvider =
    FutureProvider.autoDispose.family<String, num>((ref, amount) async {
  final accountInfo = ref.watch(getAccountInfoProvider);

  return getDeliveryFeeMethod(
    addressId: accountInfo.valueOrNull?.id ?? "",
    totalAmount: amount.toString(),
  );
});

//
final getVoucherStreamProvider =
    StreamProvider.autoDispose.family<VoucherModel, String>((ref, code) async* {
  yield* getVoucherMethod(code: code);
});

//
final checkoutNotifierProvider =
    StateNotifierProvider<CheckOutNotifier, AsyncValue>((ref) {
  return CheckOutNotifier();
});
