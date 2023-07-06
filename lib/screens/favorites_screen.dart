import 'package:flutter/material.dart';
import 'package:sneaker_store/widgets/sneaker_tile.dart';
import '../services/favorites_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesService().getFavorites().toList();

    return ListView.separated(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return SneakerTile(sneaker: favorites[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }
}
