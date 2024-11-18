import 'package:f05_lugares_app/model/lugar.dart';
import 'package:f05_lugares_app/provider/lugaresProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EditLugarModal extends StatefulWidget {
  final Lugar lugar;

  EditLugarModal({required this.lugar});

  @override
  _EditLugarModalState createState() => _EditLugarModalState();
}

class _EditLugarModalState extends State<EditLugarModal> {
  final _formKey = GlobalKey<FormState>();

  List<String> paisSelecionado = [];
  List<String> recomedacaoSelecionada = [];

  TextEditingController _tituloController = TextEditingController();
  TextEditingController _imagemURLController = TextEditingController();
  TextEditingController _recomendacao1Controller = TextEditingController();
  TextEditingController _recomendacao2Controller = TextEditingController();
  TextEditingController _recomendacao3Controller = TextEditingController();
  TextEditingController _avaliacaoController = TextEditingController();
  TextEditingController _custoMedioController = TextEditingController();
  TextEditingController _paisesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.lugar.titulo);
    _imagemURLController = TextEditingController(text: widget.lugar.imagemUrl);
    _recomendacao1Controller =
        TextEditingController(text: widget.lugar.recomendacoes[0]);
    _recomendacao2Controller = TextEditingController(
        text: widget.lugar.recomendacoes.length > 1
            ? widget.lugar.recomendacoes[1]
            : '');
    _recomendacao3Controller = TextEditingController(
        text: widget.lugar.recomendacoes.length > 2
            ? widget.lugar.recomendacoes[2]
            : '');
    _avaliacaoController =
        TextEditingController(text: widget.lugar.avaliacao.toString());
    _custoMedioController =
        TextEditingController(text: widget.lugar.custoMedio.toString());
    _paisesController = TextEditingController(text: widget.lugar.paises[0]);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _imagemURLController.dispose();
    _recomendacao1Controller.dispose();
    _recomendacao2Controller.dispose();
    _recomendacao3Controller.dispose();
    _avaliacaoController.dispose();
    _custoMedioController.dispose();
    _paisesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Editar Lugar"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                      _tituloController, 'Titulo', 'Insira o título'),
                  _buildTextField(_paisesController, 'País', 'Insira o país'),
                  _buildTextField(_imagemURLController, 'Link da imagem',
                      'Adicione o link para a imagem'),
                  _buildTextField(_custoMedioController, 'Custo médio',
                      'Insira o custo médio',
                      isNumber: true),
                  _buildTextField(_avaliacaoController, 'Avaliação',
                      'Insira uma nota de avaliação',
                      isNumber: true),
                  _buildTextField(_recomendacao1Controller,
                      'Primeira recomendação', 'Insira uma recomendação'),
                  _buildTextField(_recomendacao2Controller,
                      'Segunda recomendação', 'Insira uma recomendação',
                      isRecomendacao: true),
                  _buildTextField(_recomendacao3Controller,
                      'Terceira recomendação', 'Insira uma recomendação',
                      isRecomendacao: true)
                ],
              ))
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              try {
                paisSelecionado.add(_paisesController.text);
                if (_recomendacao1Controller.text.isNotEmpty) {
                  recomedacaoSelecionada.add(_recomendacao1Controller.text);
                }
                if (_recomendacao2Controller.text.isNotEmpty) {
                  recomedacaoSelecionada.add(_recomendacao2Controller.text);
                }
                if (_recomendacao3Controller.text.isNotEmpty) {
                  recomedacaoSelecionada.add(_recomendacao3Controller.text);
                }
                _saveChanges();
                Navigator.of(context).pop();
              } catch (e) {
                print('Erro: $e');
              }
            }
          },
          child: Text("Salvar"),
        ),
      ],
    );
  }

  void _saveChanges() {
    final provider = Provider.of<LugaresProvider>(context, listen: false);
    provider.updateLugar(
      widget.lugar.id,
      titulo: _tituloController.text,
      paises: paisSelecionado,
      avaliacao: double.tryParse(_avaliacaoController.text)!,
      custoMedio: double.tryParse(_custoMedioController.text)!,
      recomendacoes: recomedacaoSelecionada,
      imagemUrl: _imagemURLController.text,
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
}
