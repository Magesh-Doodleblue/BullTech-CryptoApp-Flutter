// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/authentication/login_authentication.dart';

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

ListView loginWidget(BuildContext context) {
    return ListView(children: [
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
                validator: loginUserNameValidation,
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
                validator: loginPassValidation,
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
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('isLoggedIn', true);
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
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }