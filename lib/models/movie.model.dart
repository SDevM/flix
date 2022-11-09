import 'dart:io';

import 'package:dio/dio.dart';

import '../utils/http.service.dart';
import '../utils/httpTools.dart';

const String _baseUrl = '/movies';
HTTP _http = HTTP();

class Movie {
  dynamic _id;
  dynamic _title;
  dynamic _year;
  dynamic _rating;
  dynamic _description;
  List<dynamic> _categories;
  dynamic _clip;
  dynamic _image;

  Movie(
    this._id,
    this._title,
    this._year,
    this._rating,
    this._description,
    this._categories,
    this._clip,
    this._image,
  );

  factory Movie.fromJson(Map<String, dynamic> source) => Movie(
        source['_id'] ?? '',
        source['title'] ?? '',
        source['year'] ?? '',
        source['rating'] ?? '',
        source['description'] ?? '',
        source['categories'],
        source['clip'] ?? '',
        source['image'] ?? '',
      );

  static Future<Map<String, dynamic>?> get(String id) async =>
      await _http.get(Uri.parse('$_baseUrl/$id'));

  static Future<Map<String, dynamic>?> getMany(PagedFiltered pageFilter) async =>
      await _http.get(Uri.parse('$_baseUrl?${pageFilter.getQueryString()}'));

  static Future<Map<String, dynamic>?> save(Map<String, Object> source) async {
    source['image'] = await MultipartFile.fromFile(source['image'] as String);
    source['clip'] = await MultipartFile.fromFile(source['clip'] as String);
    return await _http.postFD(Uri.parse(_baseUrl), FormData.fromMap(source));
  }

  Future<Map<String, dynamic>?> update() async {
    var source = toJson();
    source['image'] = File(source['image'] as String);
    source['clip'] = File(source['clip'] as String);
    return await _http.patchFD(Uri.parse('$_baseUrl/$_id'), FormData.fromMap(source));
  }

  Future<Map<String, dynamic>?> delete() async => await _http.delete(Uri.parse('$_baseUrl/$_id'));

  from(Map<String, dynamic> source) {
    _id = source['_id'] as String? ?? _id;
    _title = source['title'] as String? ?? _title;
    _year = source['year'] as String? ?? _year;
    _rating = source['rating'] as String? ?? _rating;
    _description = source['description'] as String? ?? _description;
    _categories = source['categories'] as List<dynamic>? ?? _categories;
    _clip = source['clip'] as String? ?? _clip;
    _image = source['image'] as String? ?? _image;
  }

  Map<String, Object> toJson() {
    return {
      '_id': _id,
      'title': _title,
      'year': _year,
      'rating': _rating,
      'description': _description,
      'categories': _categories,
      'clip': _clip,
      'image': _image,
    };
  }
}
