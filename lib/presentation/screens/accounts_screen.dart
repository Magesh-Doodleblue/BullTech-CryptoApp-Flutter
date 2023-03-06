// ignore_for_file: non_constant_identifier_names, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/my_profile_widget.dart';

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

          return myProfileWidget(profilePicLink: profilePicLink, userName: userName, userEmail: userEmail, userPhone: userPhone);
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
