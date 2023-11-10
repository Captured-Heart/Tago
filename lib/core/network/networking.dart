// import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tago/app.dart';

// const String baseUrl = 'https://api.tagonow.com';
// const String wsBaseUrl = 'wss://api.tagonow.com';
const String baseUrl = 'http://192.168.0.167:9800';
const String wsBaseUrl = 'ws://192.168.0.167:9800';

// AUTH URL
const String signUpUrl = '/auth/signup';
const String signInUrl = '/auth/signin';
const String sendOtpUrl = '/auth/otp';
const String forgotPasswordUrl = '/auth/forgot-password';
const String resetPasswordUrl = '/auth/reset-password';
const String verifyResetCodeUrl = '/auth/verify-resetcode';
const String verifyPhoneNumberUrl = '/verification/phone-number';

// CATEGORY URL
const String getCategoriesUrl = '/public/categories';
const String getCategoryUrl = '/public/category?label';
const String getCategoryWithSubcategoriesUrl =
    '/public/category/subcategories?label';

//PRODUCT URL
const String getProductsUrl = '/public/product?label';
const String getProductsByTagUrl = '/public/products/tag?label';

//SEARCH URL
const String getSearchUrl = '/public/search';
// ADDRESS URL
const String getAddressUrl = '/account/user/address';
const String addAddressUrl = '/account/user/address';
const String updateAddressUrl = '/account/user/address';
const String deleteAddressUrl = '/account/user/address';
const String setDefaultAddressUrl = '/account/user/address/default';

// ACCOUNT URL
const String getAccountInfoUrl = '/account/';
const String saveCurrentLocationUrl = '/account/current_location';

// WISH LIST URL
const String getWishListUrl = '/account/user/wishlist';

//DELIVERY REQUESTS
const String getDeliveryRequestUrl = '/account/rider/delivery_requests';
const String declineDeliveryRequestUrl =
    '/account/rider/delivery_request/decline';
const String acceptDeliveryRequestUrl =
    '/account/rider/delivery_request/accept';

// CARTS URL
const String getCartsUrl = '/account/user/cart';

//CHECKOUT
const String getAvailabilityUrl = '/account/user/checkout/availability';
const String checkOutUrl = '/account/user/checkout';
const String voucherUrl = '/account/user/checkout/voucher';

// ORDER
const String createAnOrderUrl = '/account/user/order';
const String getListOfOrdersUrl = '/account/user/order/orders';
const String getOrderStatusUrl = '/account/user/order/status';

//PAYMENT
const String paymentUrl = '/account/user/payment';
const String initiatePaymentUrl = '$paymentUrl/pay';
const String verifyPaymentUrl = '$paymentUrl/verify';
const String chargeCardPaymentUrl = '$paymentUrl/charge_card';
const String cardsUrl = '$paymentUrl/cards';

//RIDER
const String riderListOfOrdersUrl = '/account/rider/orders';
const String riderAcceptUrl = '/account/rider/delivery_request/accept';
const String riderDeleteUrl = '/account/rider/delivery_request/decline';
const String riderPickUpUrl = '/account/rider/order/picked_up';
const String riderDeliveredUrl = '/account/rider/order/delivered';

//
const googleAPIKey = 'AIzaSyAadW6ekHcvTwNPtq0SZd1VkB6u7m3GRB8';

//                       //! HTTP HELPER
class NetworkHelper {
  /*------------------------------------------------------------------
                    HTTP POST REQUEST
 -------------------------------------------------------------------*/
  static Future<dynamic> postRequest({
    required Map<String, dynamic> map,
    required String api,
  }) async {
    if (await Connectivity.instance.isConnected()) {
      final response = await http.post(Uri.parse('$baseUrl$api'), body: map);
      log('$baseUrl$api');

      return response;
    } else {
      showScaffoldSnackBarMessage(NetworkErrorEnums.checkYourNetwork.message,
          isError: true);
    }
  }

  /*------------------------------------------------------------------
                    HTTP GET REQUEST
 -------------------------------------------------------------------*/
  static Future<dynamic> getRequest({
    required String api,
    Map<String, String>? headers,
  }) async {
    var url = '$baseUrl$api';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      return response;
    } catch (e) {
      showScaffoldSnackBarMessage(NetworkErrorEnums.checkYourNetwork.message,
          isError: true);
    }
    // if (await Connectivity.instance.isConnected()) {
    //   final response = await http.get(
    //     Uri.parse(url),
    //     headers: headers,
    //   );

    //   return response;
    // } else {
    //   showScaffoldSnackBarMessage(NetworkErrorEnums.checkYourNetwork.message,
    //       isError: true);
    // }
  }

  /*------------------------------------------------------------------
                    HTTP GET REQUEST WITH TOKEN
 -------------------------------------------------------------------*/
  static Future<dynamic> getRequestWithToken({
    required String api,
  }) async {
    var url = '$baseUrl$api';
    if (await Connectivity.instance.isConnected()) {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer ${HiveHelper().getData(HiveKeys.token.keys)}',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );

      return response;
    } else {
      showScaffoldSnackBarMessage(NetworkErrorEnums.checkYourNetwork.message,
          isError: true);
    }
  }

/*------------------------------------------------------------------
                   HTTP POST REQUEST WITH TOKEN
 -------------------------------------------------------------------*/
  static Future<dynamic> postRequestWithToken({
    required Map<String, dynamic> map,
    required String api,
    AsyncValue? state,
  }) async {
    if (await Connectivity.instance.isConnected()) {
      final response = await http.post(
        Uri.parse('$baseUrl$api'),
        headers: {
          'Authorization':
              'Bearer ${HiveHelper().getData(HiveKeys.token.keys)}',
          // HiveHelper().getData(HiveKeys.token.keys) ?? '',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
        body: map,
      );
      // log('$baseUrl$api');
      return response;
    } else {
      showScaffoldSnackBarMessage(NetworkErrorEnums.checkYourNetwork.message,
          isError: true);
    }
  }

/*------------------------------------------------------------------
                  HTTP PATCH REQUEST WITH TOKEN
 -------------------------------------------------------------------*/
  static Future<dynamic> patchRequestWithToken({
    required String api,
    required Map<String, dynamic> map,
  }) async {
    // var url = '$baseUrl$api';
    log('$baseUrl$api');
    if (await Connectivity.instance.isConnected()) {
      final response = await http.patch(
        Uri.parse('$baseUrl$api'),
        body: map,
        headers: {
          'Authorization':
              'Bearer ${HiveHelper().getData(HiveKeys.token.keys)}',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );

      return response;
    } else {
      showScaffoldSnackBarMessage(NetworkErrorEnums.checkYourNetwork.message,
          isError: true);
    }

    // try {
    //   final response = await http.patch(
    //     Uri.parse('$baseUrl$api'),
    //     body: map,
    //     headers: {
    //       'Authorization': 'Bearer ${HiveHelper().getData(HiveKeys.token.keys)}',
    //       'Content-Type': 'application/x-www-form-urlencoded',
    //       'Connection': 'keep-alive',
    //       'Accept-Encoding': 'gzip, deflate, br',
    //     },
    //   );

    //   return response;
    // } catch (e) {
    //   showScaffoldSnackBarMessage(
    //     e.toString(),
    //     isError: true,
    //   );
    //   log('error from patchRequest: ${e.toString()}');
    // }
  }

/*------------------------------------------------------------------
                   HTTP DELETE REQUESTS WITH TOKEN
 -------------------------------------------------------------------*/
  static Future<dynamic> deleteRequestWithToken({
    required Map<String, dynamic> map,
    required String api,
  }) async {
    var url = '$baseUrl$api';

    if (await Connectivity.instance.isConnected()) {
      final response = await http.delete(
        Uri.parse(url),
        body: map,
        headers: {
          'Authorization':
              'Bearer ${HiveHelper().getData(HiveKeys.token.keys)}',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );
      log('$baseUrl$api');

      return response;
    } else {
      showScaffoldSnackBarMessage(NetworkErrorEnums.checkYourNetwork.message,
          isError: true);
    }
    // try {
    //   final response = await http.delete(
    //     Uri.parse(url),
    //     body: map,
    //     headers: {
    //       'Authorization': 'Bearer ${HiveHelper().getData(HiveKeys.token.keys)}',
    //       'Content-Type': 'application/x-www-form-urlencoded',
    //       'Connection': 'keep-alive',
    //       'Accept-Encoding': 'gzip, deflate, br',
    //     },
    //   );
    //   log('$baseUrl$api');

    //   return response;
    // } catch (e) {
    //   showScaffoldSnackBarMessage(e.toString(), isError: true);
    //   log('error from getRequest: ${e.toString()}');
    // }
  }
}
