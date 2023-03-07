// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/login_screen_widget.dart';


class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {


  // bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BULL CURRENCY',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: loginWidget(context),
    );
  }

  

}


//adding the data in textformfeild into the database firestore.  ;)

addToDatabase(String email, String userName) {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('User_details');
  Map<String, dynamic> data = {
    'User_Email': email,
    'User_Name': userName,
  };
  collectionReference.add(data).then((value) {
    print("Data added successfully!");
  }).catchError((error) {
    print("Failed to add data: $error");
  });
}
