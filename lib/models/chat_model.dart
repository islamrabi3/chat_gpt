class ChatModel {
  List<Choices>? choices;

  ChatModel({this.choices});

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(Choices.fromJson(v));
      });
    }
  }
}

// class Usage {
//   int? promptTokens;
//   int? completionTokens;
//   int? totalTokens;

//   Usage({this.promptTokens, this.completionTokens, this.totalTokens});

//   Usage.fromJson(Map<String, dynamic> json) {
//     promptTokens = json['prompt_tokens'];
//     completionTokens = json['completion_tokens'];
//     totalTokens = json['total_tokens'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['prompt_tokens'] = this.promptTokens;
//     data['completion_tokens'] = this.completionTokens;
//     data['total_tokens'] = this.totalTokens;
//     return data;
//   }
// }

class Choices {
  Message? message;
  int? index;

  Choices({this.message, this.index});

  Choices.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;

    index = json['index'];
  }
}

class Message {
  String? content;

  Message({this.content});

  Message.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }
}

class UserChatSchem {
  final String mesaage;

  UserChatSchem({required this.mesaage});
}
