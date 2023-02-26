import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'navigation_screen_home.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.adventProTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Signup '),
        ),
        body: ListView(
          children: [
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
                        } else if (confirmPasswordController !=
                            passwordController) {
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
                          );
                        }
                      },
                      color: Colors.black,
                      child: const SizedBox(
                        width: 100,
                        child: Center(
                          child: Text(
                            'Signup',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void userRegister(BuildContext context, String email, String password,
    String username) async {
  await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((authUser) {
    if (authUser.user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationButton(),
        ),
      );
    }
  }).catchError((onError) {
    print(onError);
  });
}
