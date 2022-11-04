import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flix/environment.dart';

class HTTP {
  final Dio _dio = Dio();
  final Map<String, String> headers = {
    "Access-Control-Allow-Credentials": "true",
  };

  HTTP() {
    _dio.options.baseUrl = apiUrl;
    _dio.options.headers = headers;
  }

  Future<Map<String, Object?>> get(Uri uri) async {
    try {
      Response<String> resp = await _dio.getUri(uri);
      // resp.headers['jwt_auth'];
      Map<String, Object?> data = json.decode(resp.data!);
      return (data);
    } on DioError catch (e) {
      print(e);
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw e.response!.data['error'];
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw 'Internal Error';
      }
    }
  }

  Future<Map<String, Object?>> post(
    Uri uri,
    Map<String, Object?> payload,
  ) async {
    try {
      Response<String> resp = await _dio.postUri(uri, data: payload);
      // resp.headers['jwt_auth'];
      Map<String, Object?> data = json.decode(resp.data!);
      print(data);
      return (data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw e.response!.data['error'];
      } else {
        // Something happened in setting up or sending the request that triggered an Error]
        throw 'Internal Error';
      }
    }
  }

  Future<Map<String, Object?>> patch(
    Uri uri,
    Map<String, Object?> payload,
  ) async {
    try {
      Response<String> resp = await _dio.patchUri(uri, data: payload);
      // resp.headers['jwt_auth'];
      Map<String, Object?> data = json.decode(resp.data!);
      print(data);
      return (data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw e.response!.data['error'];
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw 'Internal Error';
      }
    }
  }

  Future<Map<String, Object?>> delete(Uri uri) async {
    try {
      Response<String> resp = await _dio.deleteUri(uri);
      // resp.headers['jwt_auth'];
      Map<String, Object?> data = json.decode(resp.data!);
      print(data);
      return (data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw e.response!.data['error'];
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw 'Internal Error';
      }
    }
  }
}
