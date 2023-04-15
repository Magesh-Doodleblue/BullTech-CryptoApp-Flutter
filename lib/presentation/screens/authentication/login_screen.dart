// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/authentication/login_authentication.dart';
import 'signup_screen.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  //
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  //
  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: const Color.fromARGB(255, 255, 66, 66),
        ),
        title: const Text(
          'BULL CURRENCY',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 255, 66, 66),
          ),
        ),
      ),
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "assets/rect.png",
          ),
          ListView(children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Hero(
                      tag: "createaccount",
                      child: Center(
                        child: Text(
                          'WELCOME',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 255, 66, 66),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      child: TextFormField(
                        controller: userNameController,
                        cursorColor: const Color.fromARGB(255, 255, 66, 66),
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_pin),
                            border: InputBorder.none,
                            labelText: "Name",
                            hintText: "Type your name"),
                        validator: loginUserNameValidation,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      child: TextFormField(
                        controller: emailController,
                        cursorColor: const Color.fromARGB(255, 255, 66, 66),
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline),
                          border: InputBorder.none,
                          labelText: "Email ID",
                          hintText: "Type Email ID",
                        ),
                        validator: loginEmailValidation,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.name,
                        obscureText: _obscureText,
                        cursorColor: const Color.fromARGB(255, 255, 66, 66),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _obscureText
                                  ? Colors.black
                                  : const Color.fromARGB(255, 255, 66, 66),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: InputBorder.none,
                          labelText: "Password",
                          hintText: "Type Password",
                        ),
                        validator: loginPassValidation,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Didnt have an account! ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            debugPrint('Signup button clicked');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Create Account",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 66, 66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('isLoggedIn', true);
                              if (_formKey.currentState!.validate()) {
                                debugPrint('Login button clicked');
                                //
                                Fluttertoast.showToast(
                                  msg: "Login Success",
                                  gravity: ToastGravity.BOTTOM,
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                                //
                                signin(
                                    context,
                                    emailController.text,
                                    passwordController.text,
                                    userNameController.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 66, 66),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ])
        ],
      ),
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
