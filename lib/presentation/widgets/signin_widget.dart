// // ignore_for_file: camel_case_types

// import 'package:flutter/material.dart';

// import '../../domain/authentication/signin_authentication.dart';

// class signinWidget extends StatelessWidget {
//   const signinWidget({
//     super.key,
//     required this.formKey,
//     required this.emailController,
//     required this.userNameController,
//     required this.phoneNumberController,
//     required this.passwordController,
//     required this.confirmPasswordController,
//   });

//   final GlobalKey<FormState> formKey;
//   final TextEditingController emailController;
//   final TextEditingController userNameController;
//   final TextEditingController phoneNumberController;
//   final TextEditingController passwordController;
//   final TextEditingController confirmPasswordController;

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'WELCOME',
//                   style: TextStyle(
//                     fontSize: 30,
//                     color: Color.fromARGB(255, 255, 66, 66),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 4,
//                     vertical: 8,
//                   ),
//                   child: TextFormField(
//                     controller: emailController,
//                     cursorColor: const Color.fromARGB(255, 255, 66, 66),
//                     keyboardType: TextInputType.name,
//                     decoration: const InputDecoration(
//                       prefixIcon: Icon(Icons.mail_outline),
//                       border: InputBorder.none,
//                       labelText: "Email ID",
//                       hintText: "Type Email ID",
//                     ),
//                     validator: signinEmailValidation,
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 26,
//                 ),
//                 Container(
//                   //NEW
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 4,
//                     vertical: 8,
//                   ),
//                   child: TextFormField(
//                     controller: userNameController,
//                     cursorColor: const Color.fromARGB(255, 255, 66, 66),
//                     keyboardType: TextInputType.name,
//                     decoration: const InputDecoration(
//                         prefixIcon: Icon(Icons.person_pin),
//                         border: InputBorder.none,
//                         labelText: "Name",
//                         hintText: "Type your name"),
//                     validator: signinUserNameValidation,
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 4,
//                     vertical: 8,
//                   ),
//                   child: TextFormField(
//                     keyboardType: TextInputType.number,
//                     controller: phoneNumberController,
//                     cursorColor: const Color.fromARGB(255, 255, 66, 66),
//                     decoration: const InputDecoration(
//                       prefixIcon: Icon(Icons.phone),
//                       border: InputBorder.none,
//                       labelText: "Phone",
//                       hintText: "Give Phone number",
//                     ),
//                     validator: signinPhoneValidation,
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 26,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 4,
//                     vertical: 8,
//                   ),
//                   child: TextFormField(
//                     controller: passwordController,
//                     keyboardType: TextInputType.name,
//                     obscureText: _obscureText,
//                     cursorColor: const Color.fromARGB(255, 255, 66, 66),
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscureText
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscureText = !_obscureText;
//                           });
//                         },
//                       ),
//                       prefixIcon: const Icon(Icons.password_rounded),
//                       border: InputBorder.none,
//                       labelText: "Password",
//                       hintText: "Type Password",
//                     ),
//                     validator: signinPassValidation,
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.name,
//                   controller: passwordController,
//                   style: const TextStyle(color: Colors.black),
//                   obscureText: true,
//                   validator: signinPassValidation,
//                   decoration: InputDecoration(
//                     labelText: "Password",
//                     hintText: "Type Password",
//                     prefixIcon: const Icon(Icons.lock),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(3),
//                       gapPadding: 3,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.name,
//                   controller: confirmPasswordController,
//                   obscureText: true,
//                   style: const TextStyle(color: Colors.black),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'You forgot to enter password';
//                     } else if (value.length < 8) {
//                       return 'Password must be at least 8 characters';
//                     } else if (confirmPasswordController.text !=
//                         passwordController.text) {
//                       return 'Confirm Password should be same';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     labelText: " Confirm Password",
//                     hintText: "Type the same Password",
//                     prefixIcon: const Icon(Icons.lock),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(3),
//                       gapPadding: 3,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Already have an account! ',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     TextButton(
//                         onPressed: () {
//                           debugPrint('Login button clicked');
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Login via Account")),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 MaterialButton(
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       formKey.currentState?.save();
//                       debugPrint('Signup button clicked');
//                       userRegister(
//                         context,
//                         emailController.text,
//                         passwordController.text,
//                         phoneNumberController.text,
//                         userNameController.text,
//                       );
//                     }
//                   },
//                   color: Colors.black,
//                   child: const SizedBox(
//                     width: 120,
//                     height: 60,
//                     child: Center(
//                       child: Text(
//                         'Signup',
//                         style: TextStyle(fontSize: 24, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
