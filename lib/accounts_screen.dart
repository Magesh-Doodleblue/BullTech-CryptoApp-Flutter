// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Account')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller1,
              decoration: const InputDecoration(hintText: "ID"),
            ),
            TextFormField(
              controller: controller2,
              decoration: const InputDecoration(hintText: "name"),
            ),
            TextFormField(
              controller: controller3,
              decoration: const InputDecoration(hintText: "type"),
            ),
            TextFormField(
              controller: controller4,
              decoration: const InputDecoration(hintText: "rating"),
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

// class StreamBuilderWidget extends StatelessWidget {
//   const StreamBuilderWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<User>>(
//       stream: readUsers(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) final users = snapshot.data;
//         return ListView(
//           children: [
//             ListTile(
//               title: Text(users?.name.toList()),
//               subtitle: Text(users.type),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

Widget buildUser(User user) => ListTile(
      title: Text(user.name),
      subtitle: Text(user.type),
    );
void updateUser(
    {required String id,
    required String name,
    required String type,
    required String rating}) async {
  // update the details into firebase database (firestore) named "Users" collection
  final Userid = FirebaseFirestore.instance.collection('users').doc();
  //doc will generate random id for inserting data
  final json = {"id": id, "name": name, "type": type, "rating": rating};
  await Userid.set(json);
}

Stream<List<User>> readUsers() =>
    FirebaseFirestore.instance.collection("users").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

class User {
  late final String name;
  late final String type;

  User({required this.name, required this.type});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
