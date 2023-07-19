import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sneaker_store/widgets/sneaker_details_panel.dart';
import '../services/favorites_service.dart';
import '../services/sneaker_service.dart';
import '../services/auth_service.dart';
import '../models/sneaker_model.dart';

class SneakerTile extends StatelessWidget {
  final Sneaker sneaker;

  const SneakerTile({Key? key, required this.sneaker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sneakerService = Provider.of<SneakerService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SneakerDetailsPanel(sneaker: sneaker),
      ),
      child: Consumer<FavoritesService>(
        builder: (context, favoritesService, child) => FutureBuilder<bool>(
          future: authService.isAdmin(),
          builder: (context, snapshot) {
            return Card(
              elevation: 5,
              child: Slidable(
                startActionPane: snapshot.data == true
                    ? _buildStartActionPane(sneakerService)
                    : null,
                endActionPane: _buildEndActionPane(favoritesService),
                child: _buildSneakerTile(favoritesService),
              ),
            );
          },
        ),
      ),
    );
  }

  ActionPane _buildStartActionPane(SneakerService sneakerService) {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          label: "Delete",
          borderRadius: BorderRadius.circular(10),
          backgroundColor: Colors.red,
          icon: Icons.delete,
          onPressed: (_) async =>
              await sneakerService.deleteSneaker(sneaker.id),
        ),
      ],
    );
  }

  ActionPane _buildEndActionPane(FavoritesService favoritesService) {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          borderRadius: BorderRadius.circular(10),
          onPressed: (_) async => favoritesService.toggleFavorite(sneaker),
          icon: favoritesService.isFavorite(sneaker)
              ? Icons.favorite
              : Icons.favorite_border,
          backgroundColor: Colors.red.shade400,
          autoClose: true,
        ),
      ],
    );
  }

  Widget _buildSneakerTile(FavoritesService favoritesService) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (sneaker.images.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: sneaker.images[0],
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
                  sneaker.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${sneaker.price.toStringAsFixed(2)}",
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
    );
  }
}
