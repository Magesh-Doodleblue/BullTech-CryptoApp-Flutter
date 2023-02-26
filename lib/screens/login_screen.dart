// ignore_for_file: unrelated_type_equality_checks

import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BULL CURRENCY',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(children: [
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
                const Text(
                  'WELCOME',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: userNameController,
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Username';
                    } else if (value.length < 5) {
                      return 'Enter the valid Username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Type UserName",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      gapPadding: 3,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: passwordController,
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    } else if (!RegExp(
                            r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                        .hasMatch(value)) {
                      return 'Password should have at atleast 1 letter, 1 number, 1 special character';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Type Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      gapPadding: 3,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Didnt have an account! ',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          debugPrint('Signup button clicked');
                          Navigator.pushNamed(context, "/signup");
                        },
                        child: const Text("Create Account")),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          debugPrint('Login button clicked');
                          signin(context, userNameController.text,
                              passwordController.text, userNameController.text);
                        }
                      },
                      color: Colors.black,
                      child: const SizedBox(
                        width: 100,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const SizedBox(
                        width: 2,
                        height: 33,
                        child: Divider(thickness: 32, color: Colors.white)),
                    IconButton(
                      icon: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          'assets/google.jpg',
                          width: 35,
                          height: 35,
                        ),
                      ),
                      onPressed: () {
                        _googleSignIn.signIn().then((userData) {
                          print(userData);
                        }).catchError((e) {
                          debugPrint(e);
                        });
                      },
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       // Navigator.push(
                    //       //     context,
                    //       //     MaterialPageRoute(
                    //       //         builder: (context) => const ()));
                    //     },
                    //     // child: const Text("SSSSSSSSSSSS"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

void signin(BuildContext context, String email, String password,
    String userName) async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((authUser) {
    if (authUser.user != null) {
      Navigator.pushNamed(context, '/navigationbutton');
    }
  }).catchError((onError) {
    debugPrint(onError);
  });
}
//setting.arguments