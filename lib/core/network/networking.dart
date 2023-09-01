import 'dart:developer';
// import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tago/app.dart';
import 'package:tago/config/constants/hive_keys.dart';
import 'package:tago/config/utils/dialogs.dart';

const String baseUrl = 'http://104.248.166.210:9800';
const String signUpUrl = '/auth/signup';
const String signInUrl = '/auth/signin';
const String sendOtp = '/auth/otp';
const String forgotPasswordUrl = '/auth/forgot-password';
const String resetPasswordUrl = '/auth/reset-password';
const String verifyResetCode = '/auth/verify-resetcode';

const String getCategories = '/public/categories';
const String getCategory = '/public/category?label';

const googleAPIKey = 'AIzaSyDhKg6wsJbCyYLdjRj5m2bf5b_uUJfN8iE';

class NetworkHelper {
  static Future<dynamic> postRequest({
    required Map<String, dynamic> map,
    required String api,
  }) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl$api'), body: map);
      log('$baseUrl$api');

      return response;
    } catch (e) {
      showScaffoldSnackBarMessage(e.toString());
      log('error from postRequest: ${e.toString()}');
    }
  }

  static Future<dynamic> getRequest({required String api}) async {
    var url = '$baseUrl$api';
    try {
      final response = await http.get(Uri.parse(url));

      return response;
    } catch (e) {
      showScaffoldSnackBarMessage(e.toString());
      log('error from getRequest: ${e.toString()}');
    }
  }

  static Future<dynamic> postRequestWithToken({
    required Map<String, dynamic> map,
    required String api,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$api'),
        headers: {
          'Authorization': HiveHelper().getData(HiveKeys.token.keys) ?? '',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
        body: map,
      );
      log('$baseUrl$api');
      return response;
    } catch (e) {
      showScaffoldSnackBarMessage(e.toString());

      log('error from postRequestWithToken: ${e.toString()}');
    }
  }
}
