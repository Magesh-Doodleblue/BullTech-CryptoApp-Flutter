// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RetrieveDataFromFirestore extends StatefulWidget {
  const RetrieveDataFromFirestore({Key? key}) : super(key: key);
  @override
  _RetrieveDataFromFirestoreState createState() =>
      _RetrieveDataFromFirestoreState();
}

class _RetrieveDataFromFirestoreState extends State<RetrieveDataFromFirestore> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('User_details');
  late String userEmail;
  late String userName;
  late String userPhone;
  final bool _isUploading = false;
  String profilePicLink = "";
  late SharedPreferences prefs;
  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('profilePicLink', profilePicLink);
  }

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 100,
    );

    Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
        if (kDebugMode) {
          print(profilePicLink);
        }
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('profile_pic_link', profilePicLink);
    });
  }

  @override
  void initState() {
    super.initState();
    loadProfilePicLink();
    _initPrefs();
  }

  void loadProfilePicLink() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profilePicLink = prefs.getString('profile_pic_link') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Data'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: collectionReference.doc('UserSignInDetails').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Loading..."),
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator(),
              ],
            );
          }

          userEmail = snapshot.data!.get('User_Email');
          userName = snapshot.data!.get('User_Name');
          userPhone = snapshot.data!.get('user_phone');

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  child: dataRetrieval(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column dataRetrieval() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () async {
            pickUploadProfilePic();
          },
          child: Stack(
            children: [
              profilePicLink.isNotEmpty
                  ? CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 255, 119, 119),
                      radius: 93,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(profilePicLink),
                        radius: 90,
                      ),
                    )
                  : const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 119, 119),
                      radius: 93,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://cdn.dribbble.com/users/822638/screenshots/3877282/media/be71a9905fd107b636982b0acf051d6f.jpg?compress=1&resize=400x300&vertical=top"),
                        radius: 90,
                      ),
                    ),
              const Positioned(
                right: 0,
                left: 110,
                bottom: 0,
                child: InkWell(
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 255, 119, 119),
                    radius: 22,
                    child: Icon(
                      Icons.photo,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (_isUploading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextFormField(
          initialValue: userEmail,
          decoration: const InputDecoration(labelText: 'User Email'),
          onChanged: (value) {
            userEmail = value;
          },
        ),
        const SizedBox(
          height: 30,
        ),
        TextFormField(
          initialValue: userName,
          decoration: const InputDecoration(
            labelText: 'User Name',
          ),
          onChanged: (value) {
            userName = value;
          },
        ),
        const SizedBox(
          height: 30,
        ),
        TextFormField(
          initialValue: userPhone,
          decoration: const InputDecoration(
            labelText: 'User Phone',
          ),
          onChanged: (value) {
            userPhone = value;
          },
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                await collectionReference.doc('UserSignInDetails').update(
                  {
                    'User_Email': userEmail,
                    'User_Name': userName,
                    'user_phone': userPhone,
                  },
                );
                // Show a Toast with the message
                Fluttertoast.showToast(
                  msg: "Data Successfully Updated",
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_SHORT,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 66, 66),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Save Info',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}











// // ignore_for_file: deprecated_member_use

// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RetrieveDataFromFirestore extends StatefulWidget {
//   const RetrieveDataFromFirestore({Key? key}) : super(key: key);
//   @override
//   _RetrieveDataFromFirestoreState createState() =>
//       _RetrieveDataFromFirestoreState();
// }

// class _RetrieveDataFromFirestoreState extends State<RetrieveDataFromFirestore> {
//   final CollectionReference collectionReference =
//       FirebaseFirestore.instance.collection('User_details');
//   late String userEmail;
//   late String userName;
//   late String userPhone;
//   final bool _isUploading = false;
//   String profilePicLink = "";
//   late SharedPreferences prefs;
//   Future<void> _initPrefs() async {
//     prefs = await SharedPreferences.getInstance();
//     prefs.setString('profilePicLink', profilePicLink);
//   }

//   void pickUploadProfilePic() async {
//     final image = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       maxHeight: 512,
//       maxWidth: 512,
//       imageQuality: 100,
//     );

//     Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");

//     await ref.putFile(File(image!.path));

//     ref.getDownloadURL().then((value) async {
//       setState(() {
//         profilePicLink = value;
//         print(profilePicLink);
//       });
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setString('profile_pic_link', profilePicLink);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadProfilePicLink();
//     _initPrefs();
//   }

//   void loadProfilePicLink() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       profilePicLink = prefs.getString('profile_pic_link') ?? '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Data'),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: collectionReference.doc('UserSignInDetails').snapshots(),
//         builder:
//             (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Text('Something went wrong');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Text("Loading..."),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 CircularProgressIndicator(),
//               ],
//             );
//           }

//           userEmail = snapshot.data!.get('User_Email');
//           userName = snapshot.data!.get('User_Name');
//           userPhone = snapshot.data!.get('user_phone');

//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Form(
//               child: Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       GestureDetector(
//                         onTap: () async {
//                           pickUploadProfilePic();
//                         },
//                         child: Stack(
//                           children: [
//                             profilePicLink.isNotEmpty
//                                 ? CircleAvatar(
//                                     backgroundImage:
//                                         NetworkImage(profilePicLink),
//                                     radius: 70,
//                                   )
//                                 : const CircleAvatar(
//                                     backgroundImage: NetworkImage(
//                                         "https://cdn.dribbble.com/users/822638/screenshots/3877282/media/be71a9905fd107b636982b0acf051d6f.jpg?compress=1&resize=400x300&vertical=top"),
//                                     radius: 70.0,
//                                   ),
//                             const Positioned(
//                               right: 0,
//                               bottom: 0,
//                               child: InkWell(
//                                 child: CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 15,
//                                   child: Icon(
//                                     Icons.edit,
//                                     size: 18,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             if (_isUploading)
//                               const Center(
//                                 child: CircularProgressIndicator(),
//                               ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       TextFormField(
//                         initialValue: userEmail,
//                         decoration:
//                             const InputDecoration(labelText: 'User Email'),
//                         onChanged: (value) {
//                           userEmail = value;
//                         },
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       TextFormField(
//                         initialValue: userName,
//                         decoration: const InputDecoration(
//                           labelText: 'User Name',
//                         ),
//                         onChanged: (value) {
//                           userName = value;
//                         },
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       TextFormField(
//                         initialValue: userPhone,
//                         decoration: const InputDecoration(
//                           labelText: 'User Phone',
//                         ),
//                         onChanged: (value) {
//                           userPhone = value;
//                         },
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       SizedBox(
//                         width: 200,
//                         height: 50,
//                         child: OutlinedButton(
//                           onPressed: () async {
//                             await collectionReference
//                                 .doc('UserSignInDetails')
//                                 .update(
//                               {
//                                 'User_Email': userEmail,
//                                 'User_Name': userName,
//                                 'user_phone': userPhone,
//                               },
//                             );
//                             // Show a Toast with the message
//                             Fluttertoast.showToast(
//                               msg: "Data Successfully Updated",
//                               gravity: ToastGravity.BOTTOM,
//                               toastLength: Toast.LENGTH_SHORT,
//                             );
//                           },
//                           child: const Text('Save Info'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
