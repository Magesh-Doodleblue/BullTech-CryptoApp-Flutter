// ignore_for_file: non_constant_identifier_names

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key});

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit your Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(
                child: Image.network(
                  "https://miro.medium.com/v2/resize:fit:828/format:webp/1*odyf-x42KWo9s7jZ2qhthg.jpeg",
                ),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: controller1,
              decoration: const InputDecoration(hintText: "Username"),
            ),
            TextFormField(
              controller: controller2,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: "Phone"),
            ),
            TextFormField(
              controller: controller3,
              decoration: const InputDecoration(hintText: "Address"),
            ),
            TextFormField(
              controller: controller4,
              decoration: const InputDecoration(hintText: "give"),
            ),
            IconButton(
              onPressed: () {
                final id = controller1.text;
                final name = controller2.text;
                final type = controller3.text;
                final rating = controller4.text;
                updateUser(id: id, name: name, type: type, rating: rating);
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

void updateUser(
    {required String id,
    required String name,
    required String type,
    required String rating}) async {
  // update the details into firebase database (firestore) named "Users" collection
  final Userid = FirebaseFirestore.instance.collection('users').doc(id);
  //doc will generate random id for inserting data
  final json = {"id": id, "name": name, "type": type, "rating": rating};
  await Userid.set(json);
}
