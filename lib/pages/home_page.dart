import 'package:flutter/material.dart';
import '../board_game_card.dart';
import '../game_page.dart';
import '../notes.dart';
import '../add_game.dart';
import '../api_service.dart';

class HomePage extends StatefulWidget {
  final List<Note> notes;
  final Future<void> loader;
  final Set<Note> likedGames;
  final Set<Note> cartGames;
  final Function(Note) onLikedToggle;
  final Function(Note) onAddCart;


  const HomePage({
    Key? key,
    required this.notes,
    required this.loader,
    required this.likedGames,
    required this.cartGames,
    required this.onLikedToggle,
    required this.onAddCart,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ApiService _apiService = ApiService();

  void _navigateToAddNoteScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddGame(onNoteAdded: this.addNewNote, loader: widget.loader, lastItemId:  widget.notes.last.id)),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _apiService.createProduct(result);
      });
    }
  }

  void addNewNote(Note newNote) {
    setState(() {
      _apiService.createProduct(newNote);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настольные Игры'),
      ),
      body: Scrollbar(
        child: widget.notes.isEmpty
            ? const Center(child: Text('Пока что тут пусто, добавьте что-нибудь!'))
            : GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Количество столбцов в сетке
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.59, // Соотношение сторон элементов
          ),
          itemCount: widget.notes.length,
          itemBuilder: (context, index) {
            final note = widget.notes[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(
                      note: note,
                      loader: widget.loader,
                      id: (index + 1).toString(),
                      cartGames: widget.cartGames,
                      likedGames: widget.likedGames,
                      onAddCart: widget.onAddCart,
                      onLikedToggle: widget.onLikedToggle,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  BoardGameCard(
                    note: note,
                  ),
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
                        widget.onLikedToggle(note);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddNoteScreen(context),
        child: Icon(Icons.add),
        tooltip: 'Добавить игру',
      ),
    );
  }
}