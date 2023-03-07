
import 'package:cloud_firestore/cloud_firestore.dart';

addToDatabase(String email, String userName, String phone) {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('User_details');
  Map<String, dynamic> data = {
    'User_Email': email,
    'User_Name': userName,
    'user_phone': phone
  };
  collectionReference.doc("UserSignInDetails").set(data).then((value) {
    print("Data added successfully!");
  }).catchError((error) {
    print("Failed to add data: $error");
  });
}