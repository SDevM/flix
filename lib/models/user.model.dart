import 'package:flix/utils/http.service.dart';

const String baseUrl = '/users';
HTTP _http = HTTP();

class User {
  dynamic _id;
  dynamic _name;
  dynamic _email;
  dynamic _password;
  List<dynamic> _favorites = [];

  User(this._id, this._name, this._email, this._password);

  factory User.fromJson(Map<String, dynamic> source) {
    return User(
      source['_id'] ?? '',
      source['name'] ?? '',
      source['email'] ?? '',
      source['password'] ?? '',
    );
  }

  static Future<Map<String, dynamic>?> signUp(Map<String, Object> source) async =>
      await _http.post(Uri.parse(baseUrl), source);

  static Future<User?> signIn(Map<String, Object> source) async =>
      User.fromJson((await _http.post(Uri.parse('$baseUrl/login'), source))['data'] as Map<String, dynamic>);

  Future<Map<String, dynamic>?> session() async => await _http.get(Uri.parse(baseUrl));

  Future<Map<String, dynamic>?> logOut() async => await _http.delete(Uri.parse('/logout'));

  Future<Map<String, dynamic>?> delete() async => await _http.delete(Uri.parse(baseUrl));

  Future<Map<String, dynamic>?> update() async => await _http.patch(Uri.parse(baseUrl), toJson());

  from(Map<String, dynamic> source) {
    _id = source['_id'] as String? ?? _id;
    _favorites = source['favorites'] as List<String>? ?? _favorites;
    _name = source['name'] as String? ?? _name;
    _email = source['email'] as String? ?? _email;
    _password = source['password'] as String? ?? _password;
  }

  Map<String, Object> toJson() {
    return {
      '_id': _id,
      'email': _email,
      'name': _name,
      'password': _password,
      'favorites': _favorites,
    };
  }
}
