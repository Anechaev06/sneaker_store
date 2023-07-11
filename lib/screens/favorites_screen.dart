import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/widgets/sneaker_tile.dart';
import '../services/favorites_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesService>(
      builder: (context, favoritesService, child) {
        final favorites = favoritesService.getFavorites();

        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final sneaker = favorites.elementAt(index);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SneakerTile(sneaker: sneaker),
            );
          },
        );
      },
    );
  }
}
