import 'package:f05_lugares_app/model/pais.dart';
import 'package:f05_lugares_app/provider/paisProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EditPaisModal extends StatefulWidget {
  final Pais pais;

  EditPaisModal({required this.pais});

  @override
  _EditPaisModalState createState() => _EditPaisModalState();
}

class _EditPaisModalState extends State<EditPaisModal> {
  final _formKey = GlobalKey<FormState>();
  Color _selectedColor = Colors.blue;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Colors.blue;

  TextEditingController _tituloController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.pais.titulo);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Novo País'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            Row(
              children: [
                Text('Selecione a Cor:'),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    showColorPicker(context, (Color color) {
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
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<PaisProvider>().updatePais(widget.pais.id,
                  titulo: _tituloController.text, color: _selectedColor);

              Navigator.of(context).pop();
            }
          },
          child: Text("Adicionar"),
        ),
      ],
    );
  }

  void _saveChanges() {
    final provider = Provider.of<PaisProvider>(context, listen: false);
    provider.updatePais(
      widget.pais.id,
      titulo: _tituloController.text,
      color: _selectedColor,
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, String errorMessage,
      {bool isNumber = false, bool isRecomendacao = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
      child: Column(
        children: [
          TextFormField(
            cursorColor: Colors.black,
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[600]!)),
              border: OutlineInputBorder(),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if ((value == null || value.isEmpty) && isRecomendacao == false) {
                return errorMessage;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

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
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(labelText: 'Nome do País'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o nome do país';
                    }
                    // Verificar se o país já existe
                    final lugaresProvider = context.read<PaisProvider>();
                    if (lugaresProvider.paisesLista
                        .any((pais) => pais.titulo == value)) {
                      return 'Este país já foi adicionado!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
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
