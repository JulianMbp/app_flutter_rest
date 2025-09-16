import 'dart:convert';

import 'package:app_flutter_rest/models/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  /// Obtiene usuarios aleatorios desde https://randomuser.me
  /// Por defecto trae [results] usuarios (10 si no se especifica).
  Future<List<User>> getUsers([int results = 10]) async {
    try {
      final uri = Uri.parse('https://randomuser.me/api/?results=$results');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final List<dynamic> resultsList = body['results'] ?? [];
        return resultsList
            .map((json) => User.fromRandomUserJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  // Mantengo la función original para compatibilidad con el API anterior
  Future<User> getUserById(int id) async {
    throw UnimplementedError('getUserById is not supported for randomuser API');
  }

  /// Obtiene un solo usuario aleatorio
  Future<User> getRandomUser() async {
    final users = await getUsers(1);
    if (users.isNotEmpty) return users.first;
    throw Exception('No users returned from randomuser API');
  }
}
