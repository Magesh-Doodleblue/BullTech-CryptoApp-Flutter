import 'package:flutter/material.dart';

import '../screens/account/data_retrieval.dart';

class myProfileWidget extends StatelessWidget {
  const myProfileWidget({
    super.key,
    required this.profilePicLink,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
  });

  final String profilePicLink;
  final String userName;
  final String userEmail;
  final String userPhone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                profilePicLink.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(profilePicLink),
                        radius: 70,
                      )
                    : const Center(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://cdn.dribbble.com/users/822638/screenshots/3877282/media/be71a9905fd107b636982b0acf051d6f.jpg?compress=1&resize=400x300&vertical=top"),
                          radius: 70,
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Hi, $userName',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 44.0),
            const Text(
              "UserName",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              initialValue: userName,
              enabled: false,
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              initialValue: userEmail,
              enabled: false,
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Phone',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              initialValue: userPhone,
              enabled: false,
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: OutlinedButton(
                child: const Text('Edit Profile'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RetrieveDataFromFirestore(),
                      ),);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
