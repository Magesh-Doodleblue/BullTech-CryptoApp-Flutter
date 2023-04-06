import 'package:flutter/material.dart';

import '../../../domain/authentication/signin_authentication.dart';

class NewSignupScreen extends StatefulWidget {
  const NewSignupScreen({super.key});

  @override
  State<NewSignupScreen> createState() => _NewSignupScreenState();
}

class _NewSignupScreenState extends State<NewSignupScreen> {
  //
  //
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //
  bool obscureText = true; //password eye button
  bool passobscureText = true; //confirmpassword eye button
  //
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
          Image.asset(
            "assets/rect.png",
            // height: 600,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
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
                        // border: InputBorder.none,
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
                          // border: InputBorder.none,
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
                        // border: InputBorder.none,
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
                            color: obscureText
                                ? Colors.black
                                : const Color.fromARGB(255, 255, 66, 66),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                obscureText = !obscureText;
                              },
                            );
                          },
                        ),
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        // border: InputBorder.none,
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
                            color: passobscureText
                                ? Colors.black
                                : const Color.fromARGB(255, 255, 66, 66),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                passobscureText = !passobscureText;
                              },
                            );
                          },
                        ),
                        // border: InputBorder.none,
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
                        child: const Text(
                          "Login via Account",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 66, 66),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 54,
                    child: ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 66, 66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Signup',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
