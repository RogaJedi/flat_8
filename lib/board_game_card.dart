import 'package:flutter/material.dart';
import 'api_service.dart';
import '../notes.dart';

class BoardGameCard extends StatelessWidget {
  final Note gameNote;

  BoardGameCard({
    required this.gameNote,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(gameNote.imageUrl),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              gameNote.name,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              gameNote.basic_info,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "${gameNote.price} P",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}