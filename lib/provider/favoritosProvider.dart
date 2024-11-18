import 'package:f05_lugares_app/model/lugar.dart';
import 'package:flutter/material.dart';

class FavoritosProvider with ChangeNotifier {
  final List<Lugar> _lugaresFavoritos = [];
  List<Lugar> get favoritos => _lugaresFavoritos;
  void toggleLugarFavorito(Lugar place) {
    if (_lugaresFavoritos.contains(place)) {
      _lugaresFavoritos.remove(place);
    } else {
      _lugaresFavoritos.add(place);
    }
    notifyListeners();
  }

  
}