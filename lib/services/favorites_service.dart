// favorites_service.dart
import '../models/sneaker_model.dart';

class FavoritesService {
  static final FavoritesService _singleton = FavoritesService._internal();

  factory FavoritesService() {
    return _singleton;
  }

  FavoritesService._internal();

  final _favorites = <Sneaker>{};

  bool isFavorite(Sneaker sneaker) => _favorites.contains(sneaker);

  void addToFavorites(Sneaker sneaker) => _favorites.add(sneaker);

  void removeFromFavorites(Sneaker sneaker) => _favorites.remove(sneaker);

  Set<Sneaker> getFavorites() => _favorites;
}
