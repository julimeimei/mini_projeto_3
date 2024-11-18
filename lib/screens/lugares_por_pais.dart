import 'package:f05_lugares_app/components/item_lugar.dart';
import 'package:f05_lugares_app/provider/lugaresProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LugarPorPaisScreen extends StatelessWidget {
  LugarPorPaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém o ID do país a partir dos argumentos da rota
    final String paisId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          'Lugares do País',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<LugaresProvider>(
        builder: (ctx, lugaresProvider, child) {
          // Filtra os lugares com base no ID do país
          final lugaresFiltrados = lugaresProvider.lugaresLista
              .where((lugar) => lugar.paises.contains(paisId))
              .toList();

          return lugaresFiltrados.isEmpty
              ? Center(
                  child: Text(
                    'Nenhum lugar encontrado para este país.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: lugaresFiltrados.length,
                  itemBuilder: (ctx, i) => ItemLugar(
                    lugar: lugaresFiltrados[i],
                  ),
                );
        },
      ),
    );
  }
}
