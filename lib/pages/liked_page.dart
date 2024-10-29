import 'package:flutter/material.dart';
import '../notes.dart';
import '../board_game_card.dart';
import '../game_page.dart';

class LikedPage extends StatelessWidget {
  final List<Note> baseNotes;
  final Set<Note> likedGames;
  final Set<Note> cartGames;
  final Function(Note) onLikedToggle;
  final Function(Note) onAddCart;
  final Function(Note) onDeleteProduct;

  const LikedPage({
    Key? key,
    required this.baseNotes,
    required this.likedGames,
    required this.cartGames,
    required this.onLikedToggle,
    required this.onAddCart,
    required this.onDeleteProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final likedGamesList = likedGames.toList();
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
                    id: (index + 1).toString(),
                    cartGames: cartGames,
                    likedGames: likedGames,
                    onAddCart: onAddCart,
                    onLikedToggle: onLikedToggle,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                BoardGameCard(
                  gameNote: note,
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
                      onLikedToggle(note);
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