import 'package:f05_lugares_app/components/editLugarModal.dart';
import 'package:f05_lugares_app/model/lugar.dart';
import 'package:f05_lugares_app/provider/lugaresProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemLugar extends StatelessWidget {
  final Lugar lugar;

  ItemLugar({super.key, required this.lugar});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/detalheLugar',
          arguments: lugar,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    lugar.imagemUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      lugar.titulo,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _openEditModal(context, lugar);
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.black,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text("Excluir lugar"),
                                content: Text(
                                    "Deseja realmente excluir o lugar: ${lugar.titulo}?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Cancelar",
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<LugaresProvider>()
                                          .removeLugar(lugar.id);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Remover",
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.star),
                      const SizedBox(width: 6),
                      Text('${lugar.avaliacao}/5'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.attach_money),
                      const SizedBox(width: 6),
                      Text('Custo: R\$${lugar.custoMedio}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openEditModal(BuildContext context, Lugar lugar) {
    showDialog(
      context: context,
      builder: (ctx) {
        return EditLugarModal(lugar: lugar);
      },
    );
  }
}
