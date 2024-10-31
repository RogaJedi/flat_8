import 'package:flutter/material.dart';
import '../notes.dart';
import '../game_page.dart';

class CartPage extends StatefulWidget {
  final List<Note> notes;
  final Future<void> loader;
  final Set<Note> cartGames;
  final Set<Note> likedGames;
  final Function(Note) onLikedToggle;
  final Function(Note) onAddToCart;
  final Function(Note) onRemoveFromCart;
  final Function(Note) onDeleteFromCart;

  const CartPage({
    Key? key,
    required this.notes,
    required this.loader,
    required this.cartGames,
    required this.likedGames,
    required this.onLikedToggle,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.onDeleteFromCart,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    final cartGamesList = widget.cartGames.toList();
    int total = cartGamesList.fold(0, (sum, note) => sum + (note.price * note.amount));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: cartGamesList.isEmpty
        ? const Center(child: Text("Добавьте что-то в корзину!"),)
        : Stack(
        children: [
          ListView.builder(
            itemCount: cartGamesList.length,
            itemBuilder: (BuildContext context, int index) {
              final note = cartGamesList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(
                        gameNote: note,
                        loader: widget.loader,
                        id: (index + 1).toString(),
                        cartGames: widget.cartGames,
                        likedGames: widget.likedGames,
                        onAddCart: widget.onAddToCart,
                        onLikedToggle: widget.onLikedToggle,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Card(
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 6),
                            SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset(note.imageUrl)
                            ),
                            const SizedBox(width: 3),
                            SizedBox(
                              width: 140,
                              height: 70,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(note.name),
                                  Text("${note.price} P",),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: IconButton(
                                        onPressed: () {
                                          if (note.amount == 1) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: SizedBox(
                                                    height: 120,
                                                    width: 100,
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize
                                                            .min,
                                                        children: [
                                                          const Text("Вы хотите удалить этот товар?"),
                                                          const SizedBox(
                                                              height: 10),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  widget.onDeleteFromCart(note);
                                                                  Navigator.of(context).pop(); // Close the dialog
                                                                },
                                                                child: Text(
                                                                    "Да"),
                                                              ),
                                                              const SizedBox(
                                                                  width: 6),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop(); // Close the dialog
                                                                },
                                                                child: Text(
                                                                    "Нет"),
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
                                          }
                                          else {
                                            widget.onRemoveFromCart(note);
                                          }
                                        },
                                        icon: Icon(Icons.remove_circle, size: 40,),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "${note.amount}",
                                      style: const TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: IconButton(
                                        onPressed: () {
                                          widget.onAddToCart(note);
                                        },
                                        icon: Icon(Icons.add_circle, size: 40,),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: IconButton(
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
                                                    Text("Вы хотите удалить этот товар?"),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            widget.onDeleteFromCart(note);
                                                            Navigator.of(context).pop(); // Close the dialog
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
                                    icon: Icon(Icons.delete, size: 40),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: kBottomNavigationBarHeight - 55,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Color(0xff007500),
              child: Text(
                'Итого: ${total} P',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }

}