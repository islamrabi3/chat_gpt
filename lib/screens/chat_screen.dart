import 'package:chatgpt_course/constance/constance.dart';
import 'package:chatgpt_course/provider/chat_provider.dart';
import 'package:chatgpt_course/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController textEditingController;

  late ScrollController scrollController;

  List<String> question = [];

  @override
  void initState() {
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  void scrollMethod() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    var chatProviderModel = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/openai_logo.jpg'),
        ),
        title: const Text('Flutter Chat GPT'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 3.0),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: scrollController,
                itemCount: chatProviderModel.listOfMessageModel.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Material(
                        color: scaffoldBacgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/person.png',
                                height: 40.0,
                                width: 40.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  chatProviderModel.questionList[index],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      ChatWidget(
                        message: chatProviderModel.listOfMessageModel[index],
                      ),
                    ],
                  );
                },
              ),
            ),
            if (chatProviderModel.isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18.0,
              ),
            ],
            const SizedBox(
              height: 15.0,
            ),
            Material(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              color: userBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20.0),
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          chatProviderModel
                              .displayUserQuestion(
                                  question: textEditingController.text)
                              .then((value) {
                            // Todo send message to server

                            chatProviderModel.sendChatMsgToServer(
                                msg: textEditingController.text);
                            textEditingController.clear();
                            setState(() {
                              scrollMethod();
                            });
                          });
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: 'How can i help you ? ',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          chatProviderModel
                              .displayUserQuestion(
                                  question: textEditingController.text)
                              .then((value) {
                            // Todo send message to server

                            chatProviderModel.sendChatMsgToServer(
                                msg: textEditingController.text);
                            textEditingController.clear();
                            setState(() {
                              scrollMethod();
                            });
                          });
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
