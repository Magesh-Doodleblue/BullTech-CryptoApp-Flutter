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

// addFeedbackToDatabase(String userName, String description) {
//   final CollectionReference collectionReference =
//       FirebaseFirestore.instance.collection('User_Feedback');
//   Map<String, dynamic> data = {
//     'User_Name': userName,
//     'Description': description,
//   };
//   collectionReference.doc().set(data).then((value) {
//     print("Data added successfully!");
//     return true;
//   }).catchError((error) {
//     print("Failed to add data: $error");
//   });
// }
addFeedbackToDatabase(String userName, String description) async {
  try {
    if (userName.isEmpty || description.isEmpty) {
      throw Exception('Username and description cannot be empty');
    }

    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('User_Feedback');
    Map<String, dynamic> data = {
      'User_Name': userName,
      'Description': description,
    };

    await collectionReference.doc(userName).set(data);
    print("Data added successfully!");
    return true;
  } catch (error) {
    print("Failed to add data: $error");
    return false;
  }
}
