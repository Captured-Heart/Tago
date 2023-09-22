// import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tago/app.dart';

const String baseUrl = 'https://api.tagonow.com';

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

//PRODUCT URL
const String getProductsUrl = '/public/product?label';

//SEARCH URL
const String getSearchUrl = '/public/search';
// ADDRESS URL
const String getAddressUrl = '/account/user/address';
const String addAddressUrl = '/account/user/address';
const String updateAddressUrl = '/account/user/address';
const String deleteAddressUrl = '/account/user/address';

// ACCOUNT URL
const String getAccountInfoUrl = '/account/';

// WISH LIST URL
const String getWishListUrl = '/account/user/wishlist';

//DELIVERY REQUESTS
const String getDeliveryRequestUrl = '/account/rider/delivery_requests';
const String declineDeliveryRequestUrl = '/account/rider/delivery_request/decline';
const String acceptDeliveryRequestUrl = '/account/rider/delivery_request/accept';

// CARTS URL
const String getCartsUrl = '/account/user/cart';

//CHECKOUT
const String getAvailabilityUrl = '/account/user/checkout/availability';
const String checkOutUrl = '/account/user/checkout';
const String voucherUrl = '/account/user/checkout/voucher';
const String createAnOrderUrl = '/account/user/checkout/order';
const String getListOfOrdersUrl = '/account/user/checkout/orders';
const String getOrderStatusUrl = '/account/user/checkout/order_status';
//

//RIDER 
const String riderListOfOrdersUrl = '/account/rider/orders';

const googleAPIKey = 'AIzaSyDhKg6wsJbCyYLdjRj5m2bf5b_uUJfN8iE';

//                       //! HTTP HELPER
class NetworkHelper {
  /*------------------------------------------------------------------
                    HTTP POST REQUEST
 -------------------------------------------------------------------*/
  static Future<dynamic> postRequest({
    required Map<String, dynamic> map,
    required String api,
  }) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl$api'), body: map);
      log('$baseUrl$api');

      return response;
    } catch (e) {
      showScaffoldSnackBarMessage(e.toString(), isError: true);
      log(
        'error from postRequest: ${e.toString()}',
      );
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
      showScaffoldSnackBarMessage(e.toString(), isError: true);
      log('error from getRequest: ${e.toString()}');
    }
  }

  /*------------------------------------------------------------------
                    HTTP GET REQUEST WITH TOKEN
 -------------------------------------------------------------------*/
  static Future<dynamic> getRequestWithToken({
    required String api,
  }) async {
    var url = '$baseUrl$api';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${HiveHelper().getData(HiveKeys.token.keys)}',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );

      return response;
    } catch (e) {
      showScaffoldSnackBarMessage(
        e.toString(),
        isError: true,
      );
      log('error from getRequest: ${e.toString()}');
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
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$api'),
        headers: {
          'Authorization': 'Bearer ${HiveHelper().getData(HiveKeys.token.keys)}',
          // HiveHelper().getData(HiveKeys.token.keys) ?? '',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
        body: map,
      );
      // log('$baseUrl$api');
      return response;
    } catch (e) {
      // showScaffoldSnackBarMessage(
      //   e.toString(),
      //   isError: true,
      // );

      log('error from postRequestWithToken: ${e.toString()}');
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

    try {
      final response = await http.patch(
        Uri.parse('$baseUrl$api'),
        body: map,
        headers: {
          'Authorization': 'Bearer ${HiveHelper().getData(HiveKeys.token.keys)}',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );

      return response;
    } catch (e) {
      showScaffoldSnackBarMessage(
        e.toString(),
        isError: true,
      );
      log('error from patchRequest: ${e.toString()}');
    }
  }

/*------------------------------------------------------------------
                   HTTP DELETE REQUESTS WITH TOKEN
 -------------------------------------------------------------------*/
  static Future<dynamic> deleteRequestWithToken({
    required Map<String, dynamic> map,
    required String api,
  }) async {
    var url = '$baseUrl$api';
    try {
      final response = await http.delete(
        Uri.parse(url),
        body: map,
        headers: {
          'Authorization': 'Bearer ${HiveHelper().getData(HiveKeys.token.keys)}',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );
      log('$baseUrl$api');

      return response;
    } catch (e) {
      showScaffoldSnackBarMessage(e.toString(), isError: true);
      log('error from getRequest: ${e.toString()}');
    }
  }
}
