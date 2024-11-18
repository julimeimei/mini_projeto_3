import 'package:f05_lugares_app/data/dados.dart';
import 'package:f05_lugares_app/model/pais.dart';
import 'package:flutter/material.dart';

class PaisProvider with ChangeNotifier {
  final List<Pais> _paisesLista = [...paises]; // Lista de países existentes

  List<Pais> get paisesLista => _paisesLista;

  void addPais(Pais pais) {
    _paisesLista.add(pais);
    notifyListeners(); 
  }

  void updatePais(String id, {required String titulo,
  required Color color}) {
    final index = _paisesLista.indexWhere((pais) => pais.id == id);
    if (index >= 0) {
      _paisesLista[index] = Pais(
        id: id,
        titulo: titulo,
        cor: color
      );
      notifyListeners();
    }
  }

  void removePais(Pais pais) {
    _paisesLista.remove(pais);
    notifyListeners();
  }
}