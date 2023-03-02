// ignore_for_file: non_constant_identifier_names, unused_field

import 'dart:io';

import 'package:bulltech/screens/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'currency_converter.dart';
import 'data_retrieval.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('User_details');

  late String userEmail;
  late String userName;
  late String userPhone;
  late String profilePicLink;
  @override
  void initState() {
    loadProfilePicLink();
    super.initState();
  }

  void loadProfilePicLink() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profilePicLink = prefs.getString('profile_pic_link') ?? '';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: collectionReference.doc('UserSignInDetails').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Loading..."),
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator(),
              ],
            );
          }

          userEmail = snapshot.data!.get('User_Email');
          userName = snapshot.data!.get('User_Name');
          userPhone = snapshot.data!.get('user_phone');

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      profilePicLink.isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(profilePicLink),
                              radius: 70,
                            )
                          : const Center(
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://cdn.dribbble.com/users/822638/screenshots/3877282/media/be71a9905fd107b636982b0acf051d6f.jpg?compress=1&resize=400x300&vertical=top"),
                                radius: 70.0,
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Hi, $userName',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 44.0),
                  const Text(
                    "UserName",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    initialValue: userName,
                    enabled: false,
                    decoration: const InputDecoration(),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    initialValue: userEmail,
                    enabled: false,
                    decoration: const InputDecoration(),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Phone',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    initialValue: userPhone,
                    enabled: false,
                    decoration: const InputDecoration(),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: OutlinedButton(
                      child: const Text('Edit Profile'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RetrieveDataFromFirestore(),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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

            // OutlinedButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const ProfilePage()));
            //     },
            //     child: const Text("Edit Profile Page")),