import 'package:flutter/material.dart';
import 'notes.dart';
import 'api_service.dart';

class GamePage extends StatefulWidget {
  final String id;
  final Set<Note> cartGames;
  final Set<Note> likedGames;
  final Function(Note) onAddCart;
  final Function(Note) onLikedToggle;

  const GamePage({
    Key? key,
    required this.id,
    required this.cartGames,
    required this.likedGames,
    required this.onAddCart,
    required this.onLikedToggle,

  }) : super(key: key);


  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  Note note = Note(
      name: '',
      basic_info: '',
      imageUrl: '',
      description: '',
      price: 0,
      amount: 0
  );

  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadNote(); // Load notes when the widget initializes
  }

  Future<void> _loadNote() async {
    try {
      final loadedNote = await _apiService.getProduct(widget.id);
      setState(() {
        note = loadedNote;
      });
    } catch (e) {
      // Handle error (e.g., show a snackbar or dialog)
      print('Error loading note: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 120,
                      width: 100,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Вы хотите удалить этот товар?"),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _apiService.deleteProduct(widget.id);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Да"),
                                ),
                                const SizedBox(width: 6),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text("Нет"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            tooltip: 'Удалить товар',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(note.imageUrl),
                const Positioned(
                    top: 20,
                    right: 20,
                    child: Icon(Icons.favorite, color: Colors.white,)
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      widget.likedGames.contains(note)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.likedGames.contains(note)
                          ? Colors.red
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.onLikedToggle(note);
                      });
                    },
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.basic_info,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    note.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 400,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff504bff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed:() => widget.onAddCart(note),
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Добавить в корзину",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
