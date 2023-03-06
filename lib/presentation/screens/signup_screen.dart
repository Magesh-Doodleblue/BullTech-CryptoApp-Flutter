// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/signin_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup '),
      ),
      body: signinWidget(formKey: formKey, emailController: emailController, userNameController: userNameController, phoneNumberController: phoneNumberController, passwordController: passwordController, confirmPasswordController: confirmPasswordController),
    );
  }
}


void userRegister(BuildContext context, String email, String password,
    String phone, String username) async {
  await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((authUser) {
    if (authUser.user != null) {
      Navigator.pushNamed(context, '/navigationbutton');
      addToDatabase(email, username, phone);
    }
  }).catchError((onError) {
    print(onError);
  });
}

addToDatabase(String email, String userName, String phone) {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('User_details');
  Map<String, dynamic> data = {
    'User_Email': email,
    'User_Name': userName,
    'user_phone': phone
  };
  collectionReference.doc("UserSignInDetails").set(data).then((value) {
    print("Data added successfully!");
  }).catchError((error) {
    print("Failed to add data: $error");
  });
}
