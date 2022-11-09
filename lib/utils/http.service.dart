import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flix/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HTTP {
  final Dio _dio = Dio();

  HTTP() {
    _dio.options.baseUrl = apiUrl;
  }

  Future<Map<String, dynamic>?> get(Uri uri) async {
    final prefs = await SharedPreferences.getInstance();
    _dio.options.headers['Authorization'] = prefs.getString('jwt_auth') ?? '';
    try {
      Response<String> resp = await _dio.getUri(uri);
      if (resp.headers['jwt_auth'] != null && resp.headers['jwt_auth']!.isNotEmpty) {
        prefs.setString('jwt_auth', resp.headers['jwt_auth']![0]);
      }
      Map<String, dynamic> data = json.decode(resp.data!);
      return (data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        Map<String, dynamic> data = jsonDecode(e.response!.data);
        throw data['message'] as String;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // throw 'Internal Error, please check to ensure that you have a stable internet connection. \nThe server may also be down, in which case, our team is working to fix this problem.';
        throw '$e';
      }
    }
  }

  Future<Map<String, dynamic>> post(
    Uri uri,
    Map<String, dynamic> payload,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    _dio.options.headers['Authorization'] = prefs.getString('jwt_auth') ?? '';
    try {
      Response<String> resp = await _dio.postUri(uri, data: payload);
      if (resp.headers['jwt_auth'] != null && resp.headers['jwt_auth']!.isNotEmpty) {
        prefs.setString('jwt_auth', resp.headers['jwt_auth']![0]);
      }
      Map<String, dynamic> data = json.decode(resp.data!);
      return (data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        Map<String, dynamic> data = json.decode(e.response!.data);
        throw data['message'] as String;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // throw 'Internal Error, please check to ensure that you have a stable internet connection. \nThe server may also be down, in which case, our team is working to fix this problem.';
        throw '$e';
      }
    }
  }

  Future<Map<String, dynamic>> postFD(
    Uri uri,
    FormData payload,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    _dio.options.headers['Authorization'] = prefs.getString('jwt_auth') ?? '';
    try {
      Response<String> resp = await _dio.postUri(uri, data: payload);
      if (resp.headers['jwt_auth'] != null && resp.headers['jwt_auth']!.isNotEmpty) {
        prefs.setString('jwt_auth', resp.headers['jwt_auth']![0]);
      }
      Map<String, dynamic> data = json.decode(resp.data!);
      return (data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        Map<String, dynamic> data = json.decode(e.response!.data);
        throw data['message'] as String;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // throw 'Internal Error, please check to ensure that you have a stable internet connection. \nThe server may also be down, in which case, our team is working to fix this problem.';
        throw '$e';
      }
    }
  }

  Future<Map<String, dynamic>> patch(
    Uri uri,
    Map<String, dynamic> payload,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    _dio.options.headers['Authorization'] = prefs.getString('jwt_auth') ?? '';
    try {
      Response<String> resp = await _dio.patchUri(uri, data: payload);
      if (resp.headers['jwt_auth'] != null && resp.headers['jwt_auth']!.isNotEmpty) {
        prefs.setString('jwt_auth', resp.headers['jwt_auth']![0]);
      }
      Map<String, dynamic> data = json.decode(resp.data!);
      return (data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        Map<String, dynamic> data = json.decode(e.response!.data);
        throw data['message'] as String;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // throw 'Internal Error, please check to ensure that you have a stable internet connection. \nThe server may also be down, in which case, our team is working to fix this problem.';
        throw '$e';
      }
    }
  }

  Future<Map<String, dynamic>> patchFD(
    Uri uri,
    FormData payload,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    _dio.options.headers['Authorization'] = prefs.getString('jwt_auth') ?? '';
    try {
      Response<String> resp = await _dio.patchUri(uri, data: payload);
      if (resp.headers['jwt_auth'] != null) {
        prefs.setString('jwt_auth', resp.headers['jwt_auth']![0]);
      }
      Map<String, dynamic> data = json.decode(resp.data!);
      return (data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        Map<String, dynamic> data = json.decode(e.response!.data);
        throw data['message'] as String;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // throw 'Internal Error, please check to ensure that you have a stable internet connection. \nThe server may also be down, in which case, our team is working to fix this problem.';
        throw '$e';
      }
    }
  }

  Future<Map<String, dynamic>> delete(Uri uri) async {
    final prefs = await SharedPreferences.getInstance();
    _dio.options.headers['Authorization'] = prefs.getString('jwt_auth') ?? '';
    try {
      Response<String> resp = await _dio.deleteUri(uri);
      if (resp.headers['jwt_auth'] != null) {
        prefs.setString('jwt_auth', resp.headers['jwt_auth']![0]);
      }
      Map<String, dynamic> data = json.decode(resp.data!);
      return (data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        Map<String, dynamic> data = json.decode(e.response!.data);
        throw data['message'] as String;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // throw 'Internal Error, please check to ensure that you have a stable internet connection. \nThe server may also be down, in which case, our team is working to fix this problem.';
        throw '$e';
      }
    }
  }
}
