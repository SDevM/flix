import 'package:flix/utils/http.service.dart';

const String baseUrl = '/users';
HTTP _http = HTTP();

class User {
  String _id;
  String _name;
  String _email;
  String _password;
  List<String> _postHistory = [];

  User(this._id, this._name, this._email, this._password);

  factory User.fromJson(Map<String, Object?> source) {
    return User(
      source['_id'] as String,
      source['name'] as String,
      source['email'] as String,
      source['password'] as String,
    );
  }

  static Future<Map<String, Object?>> signUp(Map<String, Object?> source) async =>
      await _http.post(Uri.parse(baseUrl), source);

  static Future<User> signIn(Map<String, Object?> source) async =>
      User.fromJson(await _http.post(Uri.parse('$baseUrl/login'), source));

  Future<Map<String, Object?>> session() async => await _http.get(Uri.parse(baseUrl));

  Future<Map<String, Object?>> logOut() async => await _http.delete(Uri.parse('/logout'));

  Future<Map<String, Object?>> delete() async => await _http.delete(Uri.parse(baseUrl));

  Future<Map<String, Object?>> update() async => await _http.patch(Uri.parse(baseUrl), toJson());

  from(Map<String, Object?> source) {
    _id = source['_id'] as String? ?? _id;
    _postHistory = source['post_history'] as List<String>? ?? _postHistory;
    _name = source['name'] as String? ?? _name;
    _email = source['email'] as String? ?? _email;
    _password = source['password'] as String? ?? _password;
  }

  Map<String, Object?> toJson() {
    return {
      '_id': _id,
      'email': _email,
      'name': _name,
      'password': _password,
      'post_history': _postHistory,
    };
  }
}
