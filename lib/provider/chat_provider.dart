import 'dart:convert';

import 'package:chatgpt_course/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constance/constance.dart';

class ChatProvider with ChangeNotifier {
  // send chat msg to server

  ChatModel? chatModel;
  List<ChatModel> chatModelList = [];
  List<Message> listOfMessageModel = [];

  bool isTyping = false;
  sendChatMsgToServer({
    required String msg,
    int? index,
  }) async {
    final message = jsonEncode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": msg}
      ],
      "temperature": 0.7
    });

    // add user Model
    isTyping = true;
    var response = await http
        .post(
      Uri.parse(baseUrl + completionsnUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $chatGptApiKey",
      },
      body: message,
    )
        .then((value) {
      chatModel = ChatModel.fromJson(jsonDecode(value.body));
      listOfMessageModel.add(chatModel!.choices![0].message!);
      isTyping = false;
      // chatModelList.add(chatModel!);
    });
    notifyListeners();
    // Map data = jsonDecode(response.body);
  }

  // Display user Question on the screen
  List<String> questionList = [];
  Future<void> displayUserQuestion({required String question}) async {
    questionList.add(question);

    notifyListeners();
  }
}
