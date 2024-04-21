// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:tago/app.dart';
import 'package:tago/src/account/controller/card_payment_async_notifier.dart';
import 'package:tago/src/account/model/domain/card_model.dart';

final addressIdProvider = StateProvider<String>((ref) {
  return '';
});
/*------------------------------------------------------------------
                  GET ACCOUNT ADDRESS PROVIDER
 -------------------------------------------------------------------*/
final getAccountAddressProvider = FutureProvider.autoDispose<List<AddressModel>>((ref) async {
  return getAddressMethod(ref);
});

/*------------------------------------------------------------------
                  GET ACCOUNT  PROVIDER
 -------------------------------------------------------------------*/
final getAccountInfoProvider = FutureProvider.autoDispose<AccountModel>((ref) async {
  return getAccountInfoMethod();
});

/*------------------------------------------------------------------
                  GET CARDS  PROVIDER
 -------------------------------------------------------------------*/
final getCardsProvider = FutureProvider.autoDispose<List<CardModel>>((ref) async {
  return getCardsMethod(ref);
});

/*------------------------------------------------------------------
                 ACCOUNT ADDRESS STATE NOTIFIER PROVIDER
 -------------------------------------------------------------------*/
final accountAddressProvider = StateNotifierProvider<AccountAddressNotifier, AsyncValue>((ref) {
  return AccountAddressNotifier();
});

/*------------------------------------------------------------------
                  ACCOUNT ADDRESS STATE NOTIFIER 
 -------------------------------------------------------------------*/
class AccountAddressNotifier extends StateNotifier<AsyncValue> {
  AccountAddressNotifier() : super(const AsyncValue.data(null));
/*------------------------------------------------------------------
              ADD ADDRESS METHOD
 -------------------------------------------------------------------*/
  Future<String> addAddressMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
    required WidgetRef ref,
    required VoidCallback onNavigation,
  }) async {
    state = const AsyncValue.loading();
    inspect(map);
    //post request executed
    final Response response = await NetworkHelper.postRequestWithToken(
      api: addAddressUrl,
      map: map,
    );

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);
    //the response and error handling
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);
      onNavigation();
      Future.delayed(const Duration(milliseconds: 200), () {
        ref.invalidate(getAccountAddressProvider);

        showScaffoldSnackBarMessage(decodedData['message']);
      });

      return decodedData['message'];
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      return decodedData['message'];
    }
  }

  /*------------------------------------------------------------------
              EDIT ADDRESS METHOD
 -------------------------------------------------------------------*/
  Future editAddressMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = const AsyncValue.loading();
    //post request executed
    final Response response = await NetworkHelper.patchRequestWithToken(
      api: updateAddressUrl,
      map: map,
    ).catchError((er) {
      state = AsyncValue.error(er, StackTrace.empty);
      showScaffoldSnackBarMessage(er, isError: true);
    });

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);
    state = AsyncValue.data(decodedData['message']);

    //the response and error handling
    if (response.statusCode == 200) {
      state = AsyncValue.data(decodedData['message']);
      pop(context);
      Future.delayed(const Duration(milliseconds: 400), () {
        ref.invalidate(getAccountAddressProvider);

        showScaffoldSnackBarMessage(decodedData['message']);
      });

      return decodedData['message'];
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      return decodedData['message'];
    }
  }

  /*------------------------------------------------------------------
              DELETE ADDRESS METHOD
 -------------------------------------------------------------------*/
  Future deleteAddressMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = const AsyncValue.loading();
    //post request executed
    final Response response = await NetworkHelper.deleteRequestWithToken(
      api: deleteAddressUrl,
      map: map,
    );
    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);
    //the response and error handling
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);
      ref.invalidate(getAccountAddressProvider);
      showScaffoldSnackBarMessage(decodedData['message']);

      return decodedData['message'];
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      return decodedData['message'];
    }
  }

  /*------------------------------------------------------------------
              SET DEFAULT ADDRESS METHOD
 -------------------------------------------------------------------*/
  Future setDefaultAddressMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = const AsyncValue.loading();
    //post request executed
    final Response response = await NetworkHelper.patchRequestWithToken(
      api: setDefaultAddressUrl,
      map: map,
    );
    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);
    //the response and error handling
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);
      ref.invalidate(getAccountAddressProvider);
      showScaffoldSnackBarMessage(decodedData['message']);

      return decodedData['message'];
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      return decodedData['message'];
    }
  }

  /*------------------------------------------------------------------
              UPDATE PROFILE METHOD
 -------------------------------------------------------------------*/
  Future editProfileMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = const AsyncValue.loading();
    //post request executed
    final Response response = await NetworkHelper.patchRequestWithToken(
      api: getAccountInfoUrl,
      map: map,
    ).catchError((er) {
      state = AsyncValue.error(er, StackTrace.empty);
      // showScaffoldSnackBarMessage(er, isError: true);
    });

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);
    state = AsyncValue.data(decodedData['message']);

    //the response and error handling
    if (response.statusCode == 200) {
      state = AsyncValue.data(decodedData['message']);
      pop(context);
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          ref.invalidate(getAccountInfoProvider);
        }
        showScaffoldSnackBarMessage(decodedData['message']);
      });

      return decodedData['message'];
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      return decodedData['message'];
    }
  }
}
