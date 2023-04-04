// ignore_for_file: use_build_context_synchronously

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

String? loginEmailValidation(value) {
  if (value!.isEmpty) {
    return 'Enter email address';
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') //check one @ and 1 .
      .hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    int atSignCount = value.split('@').length - 1;
    int dotCount = value.split('.').length - 1;
    if (atSignCount != 1 || dotCount != 1) {
      return 'Email address must contain exactly one @ and one .';
    }
  }
  return null;
}

// void signin(BuildContext context, String email, String password,
//     String userName) async {
//   await FirebaseAuth.instance
//       .signInWithEmailAndPassword(email: email, password: password)
//       .then((authUser) {
//     if (authUser.user != null) {
//       Navigator.pushNamed(context, '/navigationbutton');
//       // addToDatabase(email, userName);
//     }
//   }).catchError((onError) {
//     debugPrint(onError);
//   });
// }

void signin(BuildContext context, String email, String password,
    String userName) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Navigator.pushNamed(
      context,
      '/navigationbutton',
      arguments: {
        // 'email': email,
        'username': userName,
      },
    );
    // addToDatabase(email, userName);
  } catch (e) {
    debugPrint("Error: $e");
    String errorMessage =
        "An error occurred while signing in. Please check your email and password and try again.";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sign in failed"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

String? loginPassValidation(value) {
  if (value!.isEmpty) {
    return 'Enter password';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters';
  } else if (!RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(value)) {
    return 'Password should have at atleast 1 letter, 1 number, 1 special character';
  }
  return null;
}
