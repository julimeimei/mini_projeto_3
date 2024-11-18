import 'package:f05_lugares_app/model/lugar.dart';
import 'package:flutter/material.dart';
import '../data/dados.dart';

class LugaresProvider with ChangeNotifier {
  final List<Lugar> _lugaresLista = [...lugares]; 

  List<Lugar> get lugaresLista => [..._lugaresLista];

  void addLugar(Lugar lugar) {
    _lugaresLista.add(lugar);
    notifyListeners();
  }

  void removeLugar(String id) {
    _lugaresLista.removeWhere((lugar) => lugar.id == id);
    notifyListeners();
  }

  

  void updateLugar(String id, {required String titulo,
  required String imagemUrl,
  required List<String> paises,
  required List<String> recomendacoes,
  required double avaliacao,
  required double custoMedio,}) {
    final index = _lugaresLista.indexWhere((lugar) => lugar.id == id);
    if (index >= 0) {
      _lugaresLista[index] = Lugar(
        id: id,
        titulo: titulo,
        imagemUrl: imagemUrl,
        paises: paises,
        recomendacoes: recomendacoes,
        avaliacao: avaliacao,
        custoMedio: custoMedio,
      );
      notifyListeners();
    }
  }

}
