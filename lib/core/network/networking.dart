// import 'dart:convert';
// import 'dart:developer';

import 'dart:convert';
import 'dart:developer';
// import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

const String baseUrl = 'http://104.248.166.210:9800';
const String signUpUrl = '/auth/signup';
const String signInUrl = '/auth/signin';
const String forgotPasswordUrl = '/auth/forgot-password';
const String resetPasswordUrl = '/auth/reset-password';
const String confirmResetPasswordUrl = '/auth/verify-resetcode';

const String getCategories = '/public/categories';

class NetworkHelper {
  // final Dio _dio = Dio();

  static Future<dynamic> postRequest({
    required Map<String, dynamic> map,
    required String api,
  }) async {
    // final Dio dio = Dio();

    final response = await http.post(Uri.parse('$baseUrl$api'), body: map);
    log('$baseUrl$api');

    return response;
  }

  static Future<dynamic> getRequest({required String api}) async {
    final Dio dio = Dio();

    var url = '$baseUrl/$api';
    Response response = await dio.get(url);

    if (response.statusCode == 200 || response.statusCode == 422) {
      String data = response.data;
      var decodedData = jsonDecode(data);
      log('Get request successful $decodedData'); //
      if (decodedData['status'] == 'false' &&
          decodedData['message'] == 'invalid_token') {
      } else {
        return decodedData;
      }
    }
  }
}
