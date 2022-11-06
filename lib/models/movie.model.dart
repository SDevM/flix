import '../utils/http.service.dart';
import '../utils/httpTools.dart';

const String _baseUrl = '/movies';
HTTP _http = HTTP();

class Movie {
  String _id;
  String _title;
  String _year;
  String _rating;
  String _description;
  String _preview;
  String _display;

  Movie(
    this._id,
    this._title,
    this._year,
    this._rating,
    this._description,
    this._preview,
    this._display,
  );

  factory Movie.fromJson(Map<String, Object?> source) => Movie(
        (source['_id'] ?? '') as String,
        (source['title'] ?? '') as String,
        (source['year'] ?? '') as String,
        (source['rating'] ?? '') as String,
        (source['description'] ?? '') as String,
        (source['preview'] ?? '') as String,
        (source['display'] ?? '') as String,
      );

  static Future<Map<String, Object?>?> get(String id) async =>
      await _http.get(Uri.parse('$_baseUrl/$id'));

  static Future<Map<String, Object?>?> getMany(PagedFiltered pageFilter) async =>
      await _http.get(Uri.parse('$_baseUrl?${pageFilter.getQueryString()}'));

  static Future<Map<String, Object?>?> save(Map<String, Object> source) async =>
      await _http.post(Uri.parse(_baseUrl), source);

  Future<Map<String, Object?>?> update() async =>
      await _http.patch(Uri.parse('$_baseUrl/$_id'), toJson());

  Future<Map<String, Object?>?> delete() async => await _http.delete(Uri.parse('$_baseUrl/$_id'));

  from(Map<String, Object> source) {
    _id = source['_id'] as String? ?? _id;
    _title = source['title'] as String? ?? _title;
    _year = source['year'] as String? ?? _year;
    _rating = source['rating'] as String? ?? _rating;
    _description = source['description'] as String? ?? _description;
    _preview = source['preview'] as String? ?? _preview;
    _display = source['display'] as String? ?? _display;
  }

  Map<String, Object> toJson() {
    return {
      '_id': _id,
      'title': _title,
      'year': _year,
      'rating': _rating,
      'description': _description,
      'preview': _preview,
      'display': _display,
    };
  }
}
