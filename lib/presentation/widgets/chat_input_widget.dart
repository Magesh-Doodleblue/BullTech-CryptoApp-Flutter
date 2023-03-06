
import 'package:flutter/material.dart';

import '../../data/models/chat_message_model.dart';

class ChatInput extends StatefulWidget {
  final ValueChanged<String> onSubmitted;
  final List<ChatMessage> messages;

  const ChatInput({required this.onSubmitted, required this.messages});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _textController = TextEditingController();

  void _handleSubmitted(String text) {
    widget.onSubmitted(text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration(
                hintText: 'Type a message',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}
