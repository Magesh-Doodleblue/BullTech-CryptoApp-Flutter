import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                  radius: 70.0,
                ),
                Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    width: 50,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.white,
                      iconSize: 26,
                      onPressed: () {
                        // Implement edit profile picture functionality
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              "widget.name",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              "widget.email",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Name',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              initialValue: "widget.name",
              decoration: const InputDecoration(
                hintText: 'Enter your name',
              ),
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
              initialValue: "widget.email",
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
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
              initialValue: '+1 123-456-7890',
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Address',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              initialValue: '123 Main St, Anytown USA',
              decoration: const InputDecoration(
                hintText: 'Enter your address',
              ),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                child: const Text('Edit Profile'),
                onPressed: () {
                  // Implement edit profile functionality
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
