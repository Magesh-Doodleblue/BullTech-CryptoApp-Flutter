
  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String? loginUserNameValidation(value) {
                if (value!.isEmpty) {
                  return 'Enter Username';
                } else if (value.length < 5) {
                  return 'Enter the valid Username';
                }
                return null;
              }

              
void signin(BuildContext context, String email, String password,
    String userName) async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((authUser) {
    if (authUser.user != null) {
      Navigator.pushNamed(context, '/navigationbutton');
      // addToDatabase(email, userName);
    }
  }).catchError((onError) {
    debugPrint(onError);
  });
}



  String? loginPassValidation(value) {
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
              }
