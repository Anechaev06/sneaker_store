// sneaker_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../services/favorites_service.dart';
import '../models/sneaker_model.dart';

class SneakerTile extends StatefulWidget {
  final Sneaker sneaker;

  const SneakerTile({super.key, required this.sneaker});

  @override
  State<SneakerTile> createState() => _SneakerTileState();
}

class _SneakerTileState extends State<SneakerTile> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = FavoritesService().isFavorite(widget.sneaker);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              onPressed: (BuildContext context) {
                setState(() {
                  isFavorite = !isFavorite;
                  if (isFavorite) {
                    FavoritesService().addToFavorites(widget.sneaker);
                  } else {
                    FavoritesService().removeFromFavorites(widget.sneaker);
                  }
                });
              },
              icon: isFavorite ? Icons.favorite : Icons.favorite_border,
              backgroundColor: Colors.red.shade400,
              autoClose: true,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  widget.sneaker.imageUrl,
                  height: 100,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.sneaker.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${widget.sneaker.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
