// ignore_for_file: camel_case_types, dead_code

import 'package:flutter/material.dart';

import '../../../domain/authentication/signin_authentication.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool obscureText = true;
  bool passobscureText = true;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Signup',
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
      body: Stack(
        children: [
          Image.asset("assets/rect.png"),
          // signinWidget(
          //   formKey: formKey,
          //   emailController: emailController,
          //   userNameController: userNameController,
          //   phoneNumberController: phoneNumberController,
          //   passwordController: passwordController,
          //   confirmPasswordController: confirmPasswordController,
          // ),
          ListView(
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
                          color: Color.fromARGB(255, 255, 66, 66),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
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
                          validator: signinEmailValidation,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Container(
                        //NEW
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
                          validator: signinUserNameValidation,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 8,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: phoneNumberController,
                          cursorColor: const Color.fromARGB(255, 255, 66, 66),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            border: InputBorder.none,
                            labelText: "Phone",
                            hintText: "Give Phone number",
                          ),
                          validator: signinPhoneValidation,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Container(
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
                          obscureText: obscureText,
                          cursorColor: const Color.fromARGB(255, 255, 66, 66),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            border: InputBorder.none,
                            labelText: "Password",
                            hintText: "Type Password",
                          ),
                          validator: signinPassValidation,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 8,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: confirmPasswordController,
                          obscureText: passobscureText,
                          cursorColor: const Color.fromARGB(255, 255, 66, 66),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            suffixIcon: IconButton(
                              icon: Icon(
                                passobscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  passobscureText = !passobscureText;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            labelText: " Confirm Password",
                            hintText: "Type the same Password",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'You forgot to enter password';
                            } else {
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              } else if (confirmPasswordController.text !=
                                  passwordController.text) {
                                return 'Confirm Password should be same';
                              }
                            }
                            return null;
                          },
                          style: Theme.of(context).textTheme.bodyLarge,
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
                            style: TextStyle(color: Colors.black),
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
                          width: 120,
                          height: 60,
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
          )
        ],
      ),
    );
  }
}
