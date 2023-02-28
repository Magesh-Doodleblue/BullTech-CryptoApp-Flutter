// // ignore_for_file: prefer_final_fields

// import 'package:flutter/material.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
// import 'package:chat_gpt_sdk/src/openai.dart';

// class ChatbotPage extends StatefulWidget {
//   @override
//   _ChatbotPageState createState() => _ChatbotPageState();
// }

// class _ChatbotPageState extends State<ChatbotPage> {
//   ChatGPTClient _client;
//   TextEditingController _messageController = TextEditingController();
//   List<ChatMessage> _messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _client = ChatGPTClient("<API_KEY>"); // Replace with your own API key
//   }

//   void _sendMessage() async {
//     String text = _messageController.text.trim();
//     if (text.isNotEmpty) {
//       ChatMessage message = ChatMessage(text, isUser: true);
//       setState(() {
//         _messages.add(message);
//       });
//       _messageController.clear();

//       String response = await _client.sendMessage(text);
//       ChatMessage botMessage = ChatMessage(response);
//       setState(() {
//         _messages.add(botMessage);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Chatbot"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (BuildContext context, int index) {
//                 ChatMessage message = _messages[index];
//                 return ListTile(
//                   title: Text(
//                     message.text,
//                     style: TextStyle(
//                       color: message.isUser ? Colors.blue : Colors.black,
//                       fontWeight:
//                           message.isUser ? FontWeight.bold : FontWeight.normal,
//                     ),
//                   ),
//                   dense: true,
//                 );
//               },
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: TextField(
//               controller: _messageController,
//               decoration: InputDecoration(
//                 hintText: "Type your message",
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ),
//               onChanged: (text) {
//                 setState(() {
//                   _messageText = text;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
