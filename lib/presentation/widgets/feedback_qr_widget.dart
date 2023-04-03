import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../domain/database_adding/database_adding.dart';
import 'toast.dart';

class feedbackQrWidget extends StatefulWidget {
  const feedbackQrWidget({
    super.key,
    required this.feedBackController,
    required this.feedBackUserNameController,
  });

  final TextEditingController feedBackController;
  final TextEditingController feedBackUserNameController;

  @override
  State<feedbackQrWidget> createState() => _feedbackQrWidgetState();
}

class _feedbackQrWidgetState extends State<feedbackQrWidget> {
  void _handlePress() {
    setState(() {
      widget.feedBackUserNameController.text = '';
      widget.feedBackController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Scan the QR code to get\n      the details of App",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              QrImage(
                data:
                    'App made by Magesh K \nApp Dev. \nAbout this app: The cryptocurrency app aims to simplify crypto investment management and provide real-time market data, news, alerts, tools, and user-friendly interface for informed trading decisions.',
                version: QrVersions.auto,
                size: 200.0,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  " FEEDBACK",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: widget.feedBackUserNameController,
                  decoration: const InputDecoration(
                    labelText: 'Give your name ',
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: widget.feedBackController,
                  decoration: const InputDecoration(
                    labelText: 'Leave your feedback here',
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 15),
                  maxLines: 5,
                  minLines: 3,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    addFeedbackToDatabase(
                      widget.feedBackUserNameController.text,
                      widget.feedBackController.text,
                    );
                    _handlePress();
                    showToast("Feedback Sent");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 66, 66),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
