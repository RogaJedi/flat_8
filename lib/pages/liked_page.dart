import 'package:flutter/material.dart';
import '../notes.dart';
import '../board_game_card.dart';
import '../game_page.dart';

class LikedPage extends StatefulWidget {
  final List<Note> notes;
  final Future<void> loader;
  final Set<Note> likedGames;
  final Set<Note> cartGames;
  final Function(Note) onLikedToggle;
  final Function(Note) onAddCart;

  const LikedPage({
    Key? key,
    required this.notes,
    required this.loader,
    required this.likedGames,
    required this.cartGames,
    required this.onLikedToggle,
    required this.onAddCart,
  }) : super(key: key);

  @override
  _LikedPageState createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage>{

  @override
  void initState() {
    super.initState();
    widget.loader; // Load notes when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    final likedGamesList = widget.likedGames.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: likedGamesList.isEmpty
        ? const Center(child: Text("Добавьте что-то в избранное!"),)
        : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.59, // Adjust as needed
        ),
        itemCount: likedGamesList.length,
        itemBuilder: (BuildContext context, int index) {
          final note = likedGamesList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(
                    note: note,
                    loader: widget.loader,
                    id: (note.id).toString(),
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
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
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
    );
  }
}