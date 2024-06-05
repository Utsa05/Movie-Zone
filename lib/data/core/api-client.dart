import 'dart:convert';

import 'package:http/http.dart';

import '../../constants/apis.dart';

class ApiClient {
  final Client _client;

  ApiClient({required Client client}) : _client = client;

  dynamic get(String path) async {
    print("${ApiConstants.baseUrl}$path?api_key=${ApiConstants.apiKey}");
    final response = await _client.get(
        Uri.parse(
          "${ApiConstants.baseUrl}$path?api_key=${ApiConstants.apiKey}",
        ),
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
