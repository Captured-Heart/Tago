// ignore_for_file: use_build_context_synchronously

import 'package:tago/app.dart';
import 'package:tago/src/account/model/domain/card_model.dart';
import 'package:tago/src/account/model/domain/text_editing_controllers.dart';

Future<List<CardModel>> getCardsMethod(AutoDisposeFutureProviderRef ref) async {
  log("load cards");
  final Response response = await NetworkHelper.getRequestWithToken(
    api: cardsUrl,
  );

  String data = response.body;
  var decodedData = jsonDecode(data);
  if (decodedData['success'] == true) {
    final cardList = (decodedData['data'] as List)
        .map((e) => CardModel.fromJson(e))
        .toList();

    return cardList;
  } else {
    return decodedData['message'];
  }
}

final payWithCardAsyncNotifierProvider =
    StateNotifierProvider<PayWithCardAsyncNotifier, AsyncValue>((ref) {
  return PayWithCardAsyncNotifier();
});

class PayWithCardAsyncNotifier extends StateNotifier<AsyncValue> {
  PayWithCardAsyncNotifier() : super(const AsyncValue.data(null));
  PaymentTextEditingControllerClass controller =
      PaymentTextEditingControllerClass();
/*------------------------------------------------------------------
                  INITIATE PAYMENT METHOD
 -------------------------------------------------------------------*/
  Future initiatePaymentAsyncMethod({
    required Map<String, String> map,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();
    final Response response = await NetworkHelper.postRequestWithToken(
      map: map,
      api: initiatePaymentUrl,
    ).timeout(const Duration(seconds: 25), onTimeout: () {
      state = const AsyncValue.data(null);
      showScaffoldSnackBarMessage('Connection timeout, try again');
    });

    var decodedData = jsonDecode(response.body);
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData);
      return decodedData['data'];
    } else {
      state = AsyncValue.error(
          decodedData['message'], StackTrace.fromString('stackTraceString'));
      showPaymentBottomSheet(
        context: context,
      );
    }
  }

  Future verifyPaymentAsyncMethod({
    required String reference,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();
    final Response response = await NetworkHelper.postRequestWithToken(
      map: {"trxref": reference},
      api: verifyPaymentUrl,
    ).timeout(const Duration(seconds: 25), onTimeout: () {
      state = const AsyncValue.data(null);
      showScaffoldSnackBarMessage('Connection timeout, try again');
    });

    String data = response.body;
    var decodedData = jsonDecode(data);

    //the response and error handling
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData);
      return decodedData;
    } else {
      state = AsyncValue.error(
          decodedData['message'], StackTrace.fromString('stackTraceString'));
      showPaymentBottomSheet(
        context: context,
      );
    }
  }

  Future chargeCardPaymentAsyncMethod({
    required Map<String, String> map,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();
    final Response response = await NetworkHelper.postRequestWithToken(
      map: map,
      api: chargeCardPaymentUrl,
    ).timeout(const Duration(seconds: 25), onTimeout: () {
      state = const AsyncValue.data(null);
      showScaffoldSnackBarMessage('Connection timeout, try again');
    });

    String data = response.body;
    var decodedData = jsonDecode(data);

    //the response and error handling
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData);
      return decodedData;
    } else {
      state = AsyncValue.error(
          decodedData['message'], StackTrace.fromString('stackTraceString'));
      showPaymentBottomSheet(
        context: context,
      );
    }
  }
}
