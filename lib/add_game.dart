import 'package:flutter/material.dart';
import '../notes.dart';
import 'package:flutter/services.dart';
import 'api_service.dart';

class AddGame extends StatefulWidget {

  @override
  _AddGameState createState() => _AddGameState();

  final Function(Note) onNoteAdded;
  final VoidCallback loader;
  AddGame({
    required this.onNoteAdded,
    required this.loader,
  });
}

class _AddGameState extends State<AddGame> {



  final TextEditingController _noteControllerTitle = TextEditingController();
  final TextEditingController _noteControllerShortInfo = TextEditingController();
  final TextEditingController _noteControllerImageURL = TextEditingController();
  final TextEditingController _noteControllerFullInfo = TextEditingController();
  final TextEditingController _noteControllerCost = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавьте новую позицию'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              controller: _noteControllerTitle,
              decoration: InputDecoration(
                labelText: 'Название',
              ),
              maxLines: 5,
            ),
            TextField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              controller: _noteControllerImageURL,
              decoration: InputDecoration(
                labelText: 'Изображение в формате URL',
              ),
              maxLines: 5,
            ),
            TextField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              controller: _noteControllerShortInfo,
              decoration: InputDecoration(
                labelText: 'Краткое описание',
              ),
              maxLines: 5,
            ),
            TextField(
              scrollPadding: EdgeInsets.only(bottom: 40),
              controller: _noteControllerFullInfo,
              decoration: InputDecoration(
                labelText: 'Полное описание',
              ),
              maxLines: 5,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              scrollPadding: EdgeInsets.only(bottom: 40),
              controller: _noteControllerCost,
              decoration: InputDecoration(
                labelText: 'Стоимость',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_noteControllerTitle.text.isNotEmpty && _noteControllerImageURL.text.isNotEmpty && _noteControllerShortInfo.text.isNotEmpty && _noteControllerFullInfo.text.isNotEmpty && _noteControllerCost.text.isNotEmpty) {
                  Note newNote = Note(name: _noteControllerTitle.text, basic_info: _noteControllerShortInfo.text, imageUrl:_noteControllerImageURL.text, description: _noteControllerFullInfo.text, price: int.parse(_noteControllerCost.text), amount: 0);
                  widget.onNoteAdded(newNote);
                  widget.loader();
                  Navigator.pop(context);
                }
              },
              child: Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}