import 'package:f05_lugares_app/components/item_pais.dart';
import 'package:f05_lugares_app/model/pais.dart';
import 'package:f05_lugares_app/provider/paisProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class PaisScreen extends StatefulWidget {
  const PaisScreen({super.key});

  @override
  State<PaisScreen> createState() => _PaisScreenState();
}

class _PaisScreenState extends State<PaisScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  Color _selectedColor = Colors.blue;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PaisProvider>(
        builder: (context, paisesProvider, child) {
          // Usando o Consumer para ouvir mudanças na lista de países
          return GridView(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 120,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
            ),
            children: getPaises(paisesProvider
                .paisesLista), // Passando a lista de países do provider
          );
        },
      ),
    );
  }

  List<Widget> getPaises(List<Pais> paises) {
    // Adicionando o botão de adição ao final da lista de países
    return [
      ...paises.map((pais) => ItemPais(pais: pais)).toList(),
      _buildAddCountryButton(),
    ];
  }

  // Função para construir o botão de adição
  Widget _buildAddCountryButton() {
    return GestureDetector(
      onTap: () {
        _openAddPaisModal(context);
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.blue,
            size: 40,
          ),
        ),
      ),
    );
  }

  // Função para abrir o modal de adicionar país
  void _openAddPaisModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Adicionar Novo País'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Campo de Título
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(labelText: 'Nome do País'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o nome do país';
                    }
                    // Verificar se o país já existe
                    final paisesProvider = context.read<PaisProvider>();
                    if (paisesProvider.paisesLista
                        .any((pais) => pais.titulo == value)) {
                      return 'Este país já foi adicionado!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                // Seletor de cor
                Row(
                  children: [
                    Text('Selecione a Cor:'),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showColorPicker(ctx, (Color color) {
                          _selectedColor = color;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        color: _selectedColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final novoPais = Pais(
                    id: _tituloController.text,
                    titulo: _tituloController.text,
                    cor: _selectedColor,
                  );

                  context.read<PaisProvider>().addPais(novoPais);

                  Navigator.of(ctx).pop();
                }
              },
              child: Text("Adicionar"),
            ),
          ],
        );
      },
    );
  }

  void changeColor(Color color) {
    setState(() {
      currentColor = color;
      pickerColor = color;
      _selectedColor = color;
    });
  }

// Função para exibir um seletor de cor
  void showColorPicker(BuildContext context, Function(Color) onColorPicked) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Escolha uma cor'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("Fechar"),
            ),
            TextButton(
              onPressed: () {
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
              child: Text("Selecionar"),
            ),
          ],
        );
      },
    );
  }
}
