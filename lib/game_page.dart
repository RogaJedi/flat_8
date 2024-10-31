import 'package:flutter/material.dart';
import 'notes.dart';
import 'api_service.dart';
import 'edit_game_page.dart';

// TODO: Page must update immediately after it's edited

class GamePage extends StatefulWidget {
  final Note note;
  final String id;
  final Set<Note> cartGames;
  final Set<Note> likedGames;
  final Function(Note) onAddCart;
  final Function(Note) onLikedToggle;
  final Future<void> loader;

  const GamePage({
    Key? key,
    required this.note,
    required this.id,
    required this.cartGames,
    required this.likedGames,
    required this.onAddCart,
    required this.onLikedToggle,
    required this.loader,

  }) : super(key: key);


  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final ApiService _apiService = ApiService();

  void _navigateToEditGame() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditGamePage(
          name: widget.note.name,
          basic_info: widget.note.basicInfo,
          imageUrl: widget.note.imageUrl,
          description: widget.note.description,
          price: widget.note.price.toString(),
        ),
      ),
    );

    if (result != null) {
      Note updatedNote = Note(
        id: widget.note.id,
        name: result['name'],
        basicInfo: result['basic_info'],
        imageUrl: result['imageUrl'],
        description: result['description'],
        price: result['price'],
        amount: 0,
      );
      _apiService.updateProduct(widget.note.id.toString(), updatedNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _navigateToEditGame,
          ),
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
                                  onPressed: () async {
                                    try {
                                      await _apiService.deleteProduct(widget.id);
                                      widget.loader;
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      // Show an error message to the user
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Failed to delete product: $e')),
                                      );
                                    }
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
                Image.network(widget.note.imageUrl),
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
                      widget.likedGames.contains(widget.note)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.likedGames.contains(widget.note)
                          ? Colors.red
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.onLikedToggle(widget.note);
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
                    widget.note.basicInfo,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.note.description,
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
                      onPressed:() => widget.onAddCart(widget.note),
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
