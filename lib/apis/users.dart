import 'dart:convert';

import 'package:bloc_example/models/users.dart';
import 'package:http/http.dart' as http;

class UserApis {
  final String _baseUrl = 'jsonplaceholder.typicode.com';

  Future<List<Users>> getUser() async {
    try {
      final uri = Uri.https(_baseUrl, '/posts');
      final response = await http.get(uri);
      final json = jsonDecode(response.body) as List;
      final users = json.map((usersJson) => Users.fromJson(usersJson)).toList();
      return users;
    } catch (e) {
      throw (e);
    }
  }
}
