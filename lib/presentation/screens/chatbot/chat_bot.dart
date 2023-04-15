// ignore_for_file: unused_import, library_private_types_in_public_api

import 'dart:async';

// import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:flutter/material.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/models/chat_message_model.dart';
import '../../widgets/chat_bubble_widget.dart';
import '../../widgets/chat_input_widget.dart';

class ChatScreens extends StatefulWidget {
  const ChatScreens({Key? key}) : super(key: key);

  @override
  _ChatScreensState createState() => _ChatScreensState();
}

class _ChatScreensState extends State<ChatScreens> {
  final List<ChatMessage> _messages = [];

  Future<String> getResponse(String message) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      body: jsonEncode(
        {
          'prompt':
              'The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly.\n\nUser: $message\n',
          'temperature': 0.5,
          'max_tokens': 15,
          'top_p': 1,
          'frequency_penalty': 0,
          'presence_penalty': 0
        },
      ),
    );

    final responseBody = jsonDecode(response.body);
    if (responseBody.containsKey('error')) {
      // Handle error response from API
      print(responseBody['error']);
      return 'Sorry, there was an error with the AI chatbot. Please try again later.';
    }

    final completions = responseBody['choices'][0]['text'];
    final textBeforeNewline = completions.split('\n')[0];

    return textBeforeNewline;
  }

  Future<void> _handleSubmitted(String text) async {
    setState(() {
      _messages.add(ChatMessage(message: text, isUserMessage: true));
    });
    final response = await getResponse(text);
    setState(() {
      _messages.add(ChatMessage(message: response, isUserMessage: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              "assets/chat.gif",
              // width: 250,
              // height: 300,
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                return ChatBubble(
                  message: message.message,
                  isUserMessage: message.isUserMessage,
                  backgroundColor: message.isUserMessage
                      ? const Color.fromARGB(255, 255, 119, 119)
                      : const Color.fromARGB(255, 201, 201, 201),
                  textColor:
                      message.isUserMessage ? Colors.white : Colors.black,
                );
              },
            ),
          ),
          ChatInput(
            onSubmitted: _handleSubmitted,
            messages: _messages,
          ),
        ],
      ),
    );
  }
}
