import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String group;
  final String phoneNumber;
  final String email;

  const EditProfilePage({
    Key? key,
    required this.name,
    required this.group,
    required this.phoneNumber,
    required this.email,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _groupController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _groupController = TextEditingController(text: widget.group);
    _phoneController = TextEditingController(text: widget.phoneNumber);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _groupController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'ФИО'),
            ),
            TextField(
              controller: _groupController,
              decoration: const InputDecoration(labelText: 'Группа'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Телефон'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Return the edited data to the previous screen
                Navigator.pop(context, {
                  'name': _nameController.text,
                  'group': _groupController.text,
                  'phoneNumber': _phoneController.text,
                  'email': _emailController.text,
                });
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}