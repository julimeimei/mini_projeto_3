import 'package:f05_lugares_app/components/editPaisModal.dart';
import 'package:f05_lugares_app/model/pais.dart';
import 'package:f05_lugares_app/provider/paisProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemPais extends StatelessWidget {
  ItemPais({super.key, required Pais pais}) : _pais = pais;
  final Pais _pais;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        
        onTap: () {
          Navigator.of(context).pushNamed(
            '/lugaresPorPais',
            arguments: _pais.id,
          );
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                colors: [
                  _pais.cor.withOpacity(0.5), //cor passad com opacidade
                  _pais.cor, //cor passada
                ],
                begin: Alignment.topLeft, //inicio do gradiente
                end: Alignment.bottomRight // fim
                ),
          ),
          child: Column(
            children: [
              Text(
                _pais.titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _openEditModal(context, _pais);
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
                                  "Deseja realmente excluir o lugar: ${_pais.titulo}?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); 
                                  },
                                  child: Text(
                                    "Cancelar",
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<PaisProvider>()
                                        .removePais(_pais);
                                    Navigator.of(context)
                                        .pop(); 
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
        ),
      ),
    );
  }

  void _openEditModal(BuildContext context, Pais pais) {
    showDialog(
      context: context,
      builder: (ctx) {
        return EditPaisModal(pais: pais);
      },
    );
  }
}
