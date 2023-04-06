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
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RetrieveDataFromFirestore(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 119, 119),
                          radius: 68,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(profilePicLink),
                            radius: 65,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RetrieveDataFromFirestore(),
                            ),
                          );
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 255, 119, 119),
                          radius: 68,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://cdn.dribbble.com/users/822638/screenshots/3877282/media/be71a9905fd107b636982b0acf051d6f.jpg?compress=1&resize=400x300&vertical=top"),
                            radius: 65,
                          ),
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
            const SizedBox(
              height: 46,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RetrieveDataFromFirestore(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 66, 66),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
