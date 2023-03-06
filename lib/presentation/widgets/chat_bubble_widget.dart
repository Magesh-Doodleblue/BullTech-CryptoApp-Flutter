
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;
  final Color backgroundColor;
  final Color textColor;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isUserMessage,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Align(
        alignment: isUserMessage ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}