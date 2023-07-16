import 'package:flutter/foundation.dart';
import 'auth_service.dart';
import '../models/sneaker_model.dart';

class FavoritesService with ChangeNotifier {
  final _favorites = <Sneaker>{};
  final AuthService _authService;

  FavoritesService(this._authService) {
    initFavorites();
  }

  Future<void> initFavorites() async {
    // Load favorite sneakers from Firestore when service is initialized
    List<Sneaker> favorites = await _authService.getFavoriteSneakers();
    _favorites
      ..clear()
      ..addAll(favorites);
    notifyListeners(); // Notify listeners when favorites change
  }

  bool isFavorite(Sneaker sneaker) => _favorites.contains(sneaker);

  Future<void> addToFavorites(Sneaker sneaker) async {
    if (!isFavorite(sneaker)) {
      _favorites.add(sneaker);
      await _authService.addFavoriteSneaker(sneaker);
      notifyListeners(); // Notify listeners when favorites change
    }
  }

  Future<void> removeFromFavorites(Sneaker sneaker) async {
    _favorites.remove(sneaker);
    await _authService.removeFavoriteSneaker(sneaker);
    notifyListeners(); // Notify listeners when favorites change
  }

  // Add or remove a sneaker from favorites based on its current status
  Future<void> toggleFavorite(Sneaker sneaker) async {
    isFavorite(sneaker)
        ? await removeFromFavorites(sneaker)
        : await addToFavorites(sneaker);
  }

  // Return an unmodifiable view of favorites
  Iterable<Sneaker> getFavorites() => _favorites.toSet();
}
