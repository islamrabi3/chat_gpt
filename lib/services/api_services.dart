import 'dart:convert';

import 'package:chatgpt_course/constance/constance.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpServicesHandler {
  static Future<Response> sendChatFromUser({String? msg}) async {
    try {
      var response =
          await http.post(Uri.parse(baseUrl + completionsnUrl), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $chatGptApiKey",
      }, body: {
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": msg}
        ],
        "temperature": 0.7
      });

      return jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
