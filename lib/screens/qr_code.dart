import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  Support({super.key});

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Scan the code to get the App",
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
                height: 10,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: feedBackController,
                  decoration: const InputDecoration(
                    labelText: 'Give your name ',
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: feedBackController,
                  decoration: const InputDecoration(
                    labelText: 'Leave your feedback here',
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 25),
                  maxLines: 5,
                  minLines: 3,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 200,
                  height: 60,
                  child: OutlinedButton(
                      onPressed: () {}, child: const Text("Submit"))),
            ],
          ),
        ),
      ),
    );
  }
}
