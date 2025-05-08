import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({super.key, this.username = "User123"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Профиль"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 10),
            Text(username, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfileScreen()));
              },
              child: Text("Редактировать профиль"),
            )
          ],
        ),
      ),
    );
  }
}
