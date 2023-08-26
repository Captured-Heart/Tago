import 'dart:developer';
// import 'dart:io';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://104.248.166.210:9800';
const String signUpUrl = '/auth/signup';
const String signInUrl = '/auth/signin';
const String forgotPasswordUrl = '/auth/forgot-password';
const String resetPasswordUrl = '/auth/reset-password';
const String confirmResetPasswordUrl = '/auth/verify-resetcode';

const String getCategories = 'public/categories';
const String getCategory = 'public/category?label';

class NetworkHelper {
  static Future<dynamic> postRequest({
    required Map<String, dynamic> map,
    required String api,
  }) async {
    final response = await http.post(Uri.parse('$baseUrl$api'), body: map);
    log('$baseUrl$api');

    return response;
  }

  static Future<dynamic> getRequest({required String api}) async {
    var url = '$baseUrl/$api';
    final response = await http.get(Uri.parse(url));

    return response;
  }
}
