import 'dart:convert';
import 'package:http/http.dart' as http;

class RemoteClient {
  final String baseUrl = 'http://api.aladhan.com/v1';

  Future<Map<String, dynamic>> get(String path) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$path'));
      return _handleResponse(response);
    } catch (e) {
      throw RemoteServerException('Failed to connect to the server. Please check your internet connection.');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw RemoteServerException('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}

class RemoteServerException implements Exception {
  final String message;

  RemoteServerException(this.message);

  @override
  String toString() => 'RemoteServerException: $message';
}
