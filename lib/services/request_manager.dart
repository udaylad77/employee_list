import 'dart:convert';
import 'package:employee_list/model/employee.dart';
import 'package:http/http.dart' as http;

class RequestManager {
  final String baseUrl;

  RequestManager(this.baseUrl);

  Future<List<Employee>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['employees'];
      return data.map((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to post data');
    }
  }
}
