import 'dart:convert';

import 'package:http/http.dart' as http;

// all todo api call will be here
class TodoServices {
  static Future<bool> deleteById(String id) async {
    // Delete the item
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    return response.statusCode == 200;
  }

  static Future<List?> fetchData() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=15';
    final uri = Uri.parse(url);
    final respose = await http.get(uri);

    if (respose.statusCode == 200) {
      final json = jsonDecode(respose.body) as Map;
      final result = json['items'] as List;

      return result;
    } else {
      return null;
    }
  }

  static Future<bool> updateTodo(String id, Map body) async {
    // submit the updated data to the server
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200;
  }

    static Future<bool> addTodo(Map body) async {
    // submit the updated data to the server
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 201;
  }
}
