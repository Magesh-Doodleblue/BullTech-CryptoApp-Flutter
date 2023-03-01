import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RetrieveDataFromFirestore extends StatelessWidget {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('User_details');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Data'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: collectionReference.doc('SignIn Details of User').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          String userEmail = snapshot.data!.get('User_Email');
          String userName = snapshot.data!.get('User_Name');
          String userPhone = snapshot.data!.get('user_phone');

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: userEmail,
                  decoration: const InputDecoration(
                    labelText: 'User Email',
                  ),
                ),
                TextFormField(
                  initialValue: userName,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                  ),
                ),
                TextFormField(
                  initialValue: userPhone,
                  decoration: const InputDecoration(
                    labelText: 'User Phone',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
