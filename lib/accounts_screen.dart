// ignore_for_file: non_constant_identifier_names, unused_field

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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

  PlatformFile? pickedFile;
//for notification

  String messageTitle = "Empty";
  String notificationAlert = "alert";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // final CollectionReference filesRef =
  //     FirebaseFirestore.instance.collection('files');
  // Future<void> addFileToFirestore() async {
  //   final CollectionReference filesRef =
  //       FirebaseFirestore.instance.collection('users');
  //   final File file = File('assets/sample_file.json' as List<Object>);
  //   final Uint8List bytes = await file.readAsBytes();
  //   await filesRef.add({
  //     'name': 'myFile.jpg',
  //     'bytes': bytes,
  //     'timestamp': FieldValue.serverTimestamp(),
  //   });
  // }

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     _firebaseMessaging.configure(
//       onMessage: (message) async{
//         setState(() {
//           messageTitle = message["notification"]["title"];
//           notificationAlert = "New Notification Alert";
//         });

//       },
//       onResume: (message) async{
//         setState(() {
//           messageTitle = message["data"]["title"];
//           notificationAlert = "Application opened from Notification";
//         });

//       },
//     );
//   }

  Future uploadfile() async {
    final path = 'users/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  Future selectfile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

//function for loaction getting
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Account')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Image.file(
            //   File(pickedFile?.path),
            //   width: 200,
            //   height: 300,
            //   fit: BoxFit.cover,
            // ),
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
            ElevatedButton(
              onPressed: () {
                selectfile();
              },
              child: const Text("Select file"),
            ),
            ElevatedButton(
              onPressed: () {
                uploadfile();
                Fluttertoast.showToast(
                    msg: "File successfully added",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey[600],
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: const Text("Upload file"),
            ),
            Text(notificationAlert),
            Text(messageTitle),
            ElevatedButton(
              onPressed: () async {
                Position position = await _determinePosition();
                debugPrint(
                    " Latitude value of user is ${position.latitude.toString()}");
                debugPrint(
                    " Longitude value of user is ${position.longitude.toString()}");
                debugPrint(
                    " Time value of user is ${position.timestamp.toString()}");
                debugPrint(
                    " Altitude value of user is ${position.altitude.toString()}");
              },
              child: const Text("GET LOCATION"),
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
  final Userid = FirebaseFirestore.instance.collection('users').doc(id);
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
