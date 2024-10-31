import 'package:flutter/material.dart';

class EditGamePage extends StatefulWidget {
  final String name;
  final String basic_info;
  final String imageUrl;
  final String description;
  final String price;

  const EditGamePage({
    Key? key,
    required this.name,
    required this.basic_info,
    required this.imageUrl,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  _EditGamePageState createState() => _EditGamePageState();
}

class _EditGamePageState extends State<EditGamePage> {
  late TextEditingController _nameController;
  late TextEditingController _basic_infoController;
  late TextEditingController _imageController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _basic_infoController = TextEditingController(text: widget.basic_info);
    _imageController = TextEditingController(text: widget.imageUrl);
    _descriptionController = TextEditingController(text: widget.description);
    _priceController = TextEditingController(text: widget.price);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _basic_infoController.dispose();
    _imageController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать игру'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: _basic_infoController,
              decoration: const InputDecoration(labelText: 'Базовое описание'),
            ),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Ссылка на изображение'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Подробное описание'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Цена'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Return the edited data to the previous screen
                Navigator.pop(context, {
                  'name': _nameController.text,
                  'basic_info': _basic_infoController.text,
                  'imageUrl': _imageController.text,
                  'description': _descriptionController.text,
                  'price': int.parse(_priceController.text),
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