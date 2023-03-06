// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../../widgets/feedback_qr_widget.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  TextEditingController feedBackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support"),
      ),
      body: feedbackQrWidget(feedBackController: feedBackController),
    );
  }
}
