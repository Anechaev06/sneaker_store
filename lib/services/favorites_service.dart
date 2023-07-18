import 'package:flutter/foundation.dart';
import 'auth_service.dart';
import '../models/sneaker_model.dart';

class FavoritesService with ChangeNotifier {
  final _favorites = <Sneaker>{};
  final AuthService _authService;

  FavoritesService(this._authService);

  Future<void> initFavorites() async {
    _favorites
      ..clear()
      ..addAll(await _authService.getFavoriteSneakers());
    notifyListeners();
  }

  bool isFavorite(Sneaker sneaker) => _favorites.contains(sneaker);

  Future<void> toggleFavorite(Sneaker sneaker) async {
    if (isFavorite(sneaker)) {
      await removeFromFavorites(sneaker);
    } else {
      await addToFavorites(sneaker);
    }
  }

  Future<void> addToFavorites(Sneaker sneaker) async {
    _favorites.add(sneaker);
    await _authService.addFavoriteSneaker(sneaker);
    notifyListeners();
  }

  Future<void> removeFromFavorites(Sneaker sneaker) async {
    _favorites.remove(sneaker);
    await _authService.removeFavoriteSneaker(sneaker);
    notifyListeners();
  }

  Iterable<Sneaker> getFavorites() => _favorites.toSet();

  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}
