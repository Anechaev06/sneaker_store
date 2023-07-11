import '../models/sneaker_model.dart';
import 'package:flutter/foundation.dart';

class FavoritesService with ChangeNotifier {
  final _favorites = <Sneaker>{};

  bool isFavorite(Sneaker sneaker) => _favorites.contains(sneaker);

  void addToFavorites(Sneaker sneaker) {
    if (!isFavorite(sneaker)) {
      _favorites.add(sneaker);
      notifyListeners(); // Notify listeners when favorites change
    }
  }

  void removeFromFavorites(Sneaker sneaker) {
    _favorites.remove(sneaker);
    notifyListeners(); // Notify listeners when favorites change
  }

  // Add or remove a sneaker from favorites based on its current status
  void toggleFavorite(Sneaker sneaker) {
    isFavorite(sneaker)
        ? removeFromFavorites(sneaker)
        : addToFavorites(sneaker);
  }

  // Return an unmodifiable view of favorites
  Iterable<Sneaker> getFavorites() => _favorites.toSet();
}
