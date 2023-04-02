import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt_course/constance/constance.dart';
import 'package:chatgpt_course/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: userBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/chat_logo.png',
                  height: 40.0,
                  width: 40.0,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TyperAnimatedText('${message.content}',
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
