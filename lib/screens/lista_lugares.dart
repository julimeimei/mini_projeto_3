import 'package:f05_lugares_app/components/item_lugar.dart';
import 'package:f05_lugares_app/provider/lugaresProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaLugaresScreen extends StatefulWidget {
  const ListaLugaresScreen({super.key});
  @override
  State<ListaLugaresScreen> createState() => _ListaLugaresScreenState();
}

class _ListaLugaresScreenState extends State<ListaLugaresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          'Lista de lugares',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<LugaresProvider>(
        builder: (ctx, lugaresProvider, child) {
          final lugares =
              lugaresProvider.lugaresLista; // Obtém a lista de lugares
          return ListView.builder(
            itemCount: lugares.length,
            itemBuilder: (ctx, i) => ItemLugar(
              lugar: lugares[i],
            ),
          );
        },
      ),
    );
  }
}
