import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  Future getQuiz(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Exception('Failed to load data');
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
