import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController(text: "User123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Редактировать профиль"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Будет загрузка фото (пока заглушка)
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Изменение аватарки пока не реализовано")));
              },
              child: CircleAvatar(
                radius: 50,
                child: Icon(Icons.edit, size: 50),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Имя пользователя"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // здесь будет логика сохранения
                Navigator.pop(context);
              },
              child: Text("Сохранить"),
            )
          ],
        ),
      ),
    );
  }
}
