import 'package:flutter/material.dart';
import 'notes.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/liked_page.dart';
import 'pages/cart_page.dart';
import 'api_service.dart'; // Import the API service

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note> notes = []; // Initialize an empty list
  final ApiService _apiService = ApiService(); // Create an instance of ApiService

  int _selectedIndex = 0;
  final Set<Note> likedGames = {};
  final Set<Note> cartGames = {};

  @override
  void initState() {
    super.initState();
    _loadNotes(); // Load notes when the widget initializes
  }

  Future<void> _loadNotes() async {
    try {
      final loadedNotes = await _apiService.getProducts();
      setState(() {
        notes = loadedNotes;
      });
    } catch (e) {
      // Handle error (e.g., show a snackbar or dialog)
      print('Error loading notes: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Note note) {
    setState(() {
      if (likedGames.contains(note)) {
        likedGames.remove(note);
      } else {
        likedGames.add(note);
      }
    });
  }

  void _addToCart(Note note) {
    setState(() {
      note.amount += 1;
      cartGames.add(note);
    });
  }

  void _removeFromCart(Note note) {
    setState(() {
      note.amount -= 1;
    });
  }

  void _deleteFromCart(Note note) {
    setState(() {
      note.amount = 0;
      cartGames.remove(note);
    });
  }

  void _deleteProduct(Note note) {
    setState(() {
      notes.remove(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(
        baseNotes: notes,
        likedGames: likedGames,
        cartGames: cartGames,
        onLikedToggle: _toggleFavorite,
        onAddCart: _addToCart,
        onDeleteProduct: _deleteProduct,
      ),
      LikedPage(
        baseNotes: notes,
        likedGames: likedGames,
        cartGames: cartGames,
        onLikedToggle: _toggleFavorite,
        onAddCart: _addToCart,
        onDeleteProduct: _deleteProduct,
      ),
      CartPage(
        baseNotes: notes,
        cartGames: cartGames,
        likedGames: likedGames,
        onAddToCart: _addToCart,
        onLikedToggle: _toggleFavorite,
        onRemoveFromCart: _removeFromCart,
        onDeleteFromCart: _deleteFromCart,
        onDeleteProduct: _deleteProduct,
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff504bff),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
