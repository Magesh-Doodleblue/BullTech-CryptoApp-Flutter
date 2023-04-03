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
  TextEditingController feedBackUserNameController = TextEditingController();
  @override
  void dispose() {
    feedBackController.dispose();
    feedBackUserNameController.dispose();
    super.dispose();
  }

  void _handlePress() {
    setState(() {
      feedBackUserNameController.text = '';
      feedBackController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support"),
      ),
      body: feedbackQrWidget(
        feedBackController: feedBackController,
        feedBackUserNameController: feedBackUserNameController,
      ),
    );
  }
}
