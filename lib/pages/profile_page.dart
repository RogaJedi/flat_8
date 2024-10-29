import 'package:flutter/material.dart';
import '../edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String name = 'Колпащиков Иван Михайлович';
  String group = 'ЭФБО-03-22';
  String phoneNumber = '+7 (888) 999-00-11';
  String email = 'mail@mail.mail';

  void _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          name: name,
          group: group,
          phoneNumber: phoneNumber,
          email: email,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        name = result['name'];
        group = result['group'];
        phoneNumber = result['phoneNumber'];
        email = result['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                group,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Телефон: $phoneNumber',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Email: $email',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToEditProfile,
        child: Icon(Icons.edit),
        tooltip: 'Добавить игру',
      ),
    );
  }
}