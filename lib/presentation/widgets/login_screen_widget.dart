// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../domain/authentication/login_authentication.dart';

// TextEditingController userNameController = TextEditingController();
// TextEditingController emailController = TextEditingController();
// TextEditingController passwordController = TextEditingController();
// final _formKey = GlobalKey<FormState>();
// bool _obscureText = true;
// // final GoogleSignIn _googleSignIn = GoogleSignIn();

// ListView loginWidget(BuildContext context) {
//   return ListView(children: [
//     Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 100,
//             ),
//             const Hero(
//               tag: "createaccount",
//               child: Text(
//                 'WELCOME',
//                 style: TextStyle(
//                   fontSize: 30,
//                   color: Color.fromARGB(255, 255, 66, 66),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 45,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 4,
//                 vertical: 8,
//               ),
//               child: TextFormField(
//                 controller: emailController,
//                 cursorColor: const Color.fromARGB(255, 255, 66, 66),
//                 keyboardType: TextInputType.name,
//                 decoration: const InputDecoration(
//                   prefixIcon: Icon(Icons.mail_outline),
//                   border: InputBorder.none,
//                   labelText: "Email ID",
//                   hintText: "Type Email ID",
//                 ),
//                 validator: loginEmailValidation,
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 4,
//                 vertical: 8,
//               ),
//               child: TextFormField(
//                 controller: userNameController,
//                 cursorColor: const Color.fromARGB(255, 255, 66, 66),
//                 keyboardType: TextInputType.name,
//                 decoration: const InputDecoration(
//                     prefixIcon: Icon(Icons.person_pin),
//                     border: InputBorder.none,
//                     labelText: "Name",
//                     hintText: "Type your name"),
//                 validator: loginUserNameValidation,
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             // TextFormField(
//             //   cursorColor: const Color.fromARGB(255, 255, 66, 66),
//             //   keyboardType: TextInputType.name,
//             //   controller: userNameController,
//             //   style: const TextStyle(color: Colors.black),
//             //   validator: loginUserNameValidation,
//             //   decoration: InputDecoration(
//             //     labelText: "Email ID",
//             //     hintText: "Type Email ID",
//             //     prefixIcon: const Icon(Icons.person),
//             //     border: OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(3),
//             //       gapPadding: 3,
//             //     ),
//             //   ),
//             // ),

//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 4,
//                 vertical: 8,
//               ),
//               child: TextFormField(
//                 controller: passwordController,
//                 keyboardType: TextInputType.name,
//                 obscureText: _obscureText,
//                 cursorColor: const Color.fromARGB(255, 255, 66, 66),
//                 decoration: InputDecoration(
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscureText ? Icons.visibility_off : Icons.visibility,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscureText = !_obscureText;
//                       });
//                     },
//                   ),
//                   prefixIcon: const Icon(Icons.password_rounded),
//                   border: InputBorder.none,
//                   labelText: "Password",
//                   hintText: "Type Password",
//                 ),
//                 validator: loginPassValidation,
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             // TextFormField(
//             //   controller: passwordController,
//             //   keyboardType: TextInputType.name,
//             //   cursorColor: const Color.fromARGB(255, 255, 66, 66),
//             //   style: const TextStyle(color: Colors.black),
//             //   obscureText: true,
//             //   validator: loginPassValidation,
//             //   decoration: InputDecoration(
//             //     labelText: "Password",
//             //     hintText: "Type Password",
//             //     prefixIcon: const Icon(Icons.lock),
//             //     border: OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(3),
//             //       gapPadding: 3,
//             //     ),
//             //   ),
//             // ),
//             // const SizedBox(
//             //   height: 20,
//             // ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Didnt have an account! ',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     debugPrint('Signup button clicked');
//                     Navigator.pushNamed(context, "/signup");
//                   },
//                   child: const Text(
//                     "Create Account",
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 255, 66, 66),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: 200,
//                   height: 54,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       final prefs = await SharedPreferences.getInstance();
//                       prefs.setBool('isLoggedIn', true);
//                       if (_formKey.currentState!.validate()) {
//                         debugPrint('Login button clicked');
//                         // showLoadingDialog(context);
//                         signin(context, userNameController.text,
//                             passwordController.text, userNameController.text);
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 255, 66, 66),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                     ),
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(fontSize: 24, color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 // const SizedBox(
//                 //   width: 2,
//                 //   height: 33,
//                 //   child: Divider(thickness: 32, color: Colors.black),
//                 // ),
//                 // const SizedBox(width: 13),
//                 // MaterialButton(
//                 //   onPressed: () async {
//                 //     final prefs = await SharedPreferences.getInstance();
//                 //     prefs.setBool('isLoggedIn', true);
//                 //     if (_formKey.currentState!.validate()) {
//                 //       debugPrint('Login button clicked');
//                 //       signin(context, userNameController.text,
//                 //           passwordController.text, userNameController.text);
//                 //     }
//                 //   },
//                 //   color: Colors.black,
//                 //   child: const SizedBox(
//                 //     width: 100,
//                 //     child: Center(
//                 //       child: Text(
//                 //         'Login',
//                 //         style: TextStyle(fontSize: 24, color: Colors.white),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 // const SizedBox(width: 13),
//                 // const SizedBox(
//                 //     width: 2,
//                 //     height: 33,
//                 //     child: Divider(thickness: 32, color: Colors.black)),
//                 // IconButton(
//                 //   icon: ClipRRect(
//                 //     borderRadius: BorderRadius.circular(40),
//                 //     child: Image.asset(
//                 //       'assets/google.jpg',
//                 //       width: 35,
//                 //       height: 35,
//                 //     ),
//                 //   ),
//                 //   onPressed: () {
//                 //     _googleSignIn.signIn().then((userData) {
//                 //       print(userData);
//                 //     }).catchError((e) {
//                 //       debugPrint(e);
//                 //     });
//                 //   },
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   ]);
// }
