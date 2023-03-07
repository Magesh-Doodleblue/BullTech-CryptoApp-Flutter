// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../../widgets/signin_widget.dart';

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


