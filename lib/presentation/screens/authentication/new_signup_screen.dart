import 'package:flutter/material.dart';

import '../../../domain/authentication/signin_authentication.dart';

class NewSignupScreen extends StatefulWidget {
  const NewSignupScreen({Key? key}) : super(key: key);

  @override
  State<NewSignupScreen> createState() => _NewSignupScreenState();
}

class _NewSignupScreenState extends State<NewSignupScreen> {
  //

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //  //
  bool obscureText = true; //password eye button
  bool passobscureText = true; //confirmpassword eye button

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Signup ',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 66, 66),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: const Color.fromARGB(255, 255, 66, 66),
        ),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/rect.png",
                // height: 600,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter email address';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') //check one @ and 1 .
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
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Type Email ID",
                          prefixIcon: const Icon(Icons.mail),
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
                        controller: userNameController,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You forgot to give Username';
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
                        controller: phoneNumberController,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You forgot to enter phone number';
                          } else if (value.length != 10) {
                            return 'Phone should have 10 Digits';
                          } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Phone",
                          hintText: "Give Phone number",
                          prefixIcon: const Icon(Icons.phone),
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
                            return 'You forgot to enter password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          } else if (!RegExp(
                                  r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return 'Password should have at @1least 1 letter, 1 number, 1 special character';
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
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: confirmPasswordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You forgot to enter password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          } else if (confirmPasswordController.text !=
                              passwordController.text) {
                            return 'Confirm Password should be same';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: " Confirm Password",
                          hintText: "Type the same Password",
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
                            'Already have an account! ',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                              onPressed: () {
                                debugPrint('Login button clicked');
                                Navigator.pop(context);
                              },
                              child: const Text("Login via Account")),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState?.save();
                            debugPrint('Signup button clicked');
                            userRegister(
                              context,
                              emailController.text,
                              passwordController.text,
                              phoneNumberController.text,
                              userNameController.text,
                            );
                          }
                        },
                        color: Colors.black,
                        child: const SizedBox(
                          width: 100,
                          child: Center(
                            child: Text(
                              'Signup',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
