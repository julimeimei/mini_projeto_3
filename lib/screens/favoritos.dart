import 'package:f05_lugares_app/components/item_lugar.dart';
import 'package:f05_lugares_app/provider/favoritosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritosProvider>(builder: (context, favoritoValue, child) {
      if (favoritoValue.favoritos.isEmpty) {
      return const Center(
        child: Text('Nenhum Lugar Marcado como Favorito!', style: TextStyle(fontSize: 20),),
      );
    } else {
      return ListView.builder(
          itemCount: favoritoValue.favoritos.length,
          itemBuilder: (ctx, index) {
            return ItemLugar(lugar: favoritoValue.favoritos.elementAt(index),);
          });
    }
    },);
    
  }
}