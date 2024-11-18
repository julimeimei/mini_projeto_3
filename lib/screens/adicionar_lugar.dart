import 'package:f05_lugares_app/model/lugar.dart';
import 'package:f05_lugares_app/provider/lugaresProvider.dart';
import 'package:f05_lugares_app/provider/paisProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AdicionarLugarScreen extends StatefulWidget {
  AdicionarLugarScreen({super.key});

  @override
  State<AdicionarLugarScreen> createState() => _AdicionarLugarScreenState();
}

class _AdicionarLugarScreenState extends State<AdicionarLugarScreen> {
  final _formKey = GlobalKey<FormState>();

  String? paisSelecionado;
  List<String> recomedacaoSelecionada = [];

  TextEditingController _tituloController = TextEditingController();
  TextEditingController _imagemURLController = TextEditingController();
  TextEditingController _recomendacao1Controller = TextEditingController();
  TextEditingController _recomendacao2Controller = TextEditingController();
  TextEditingController _recomendacao3Controller = TextEditingController();
  TextEditingController _avaliacaoController = TextEditingController();
  TextEditingController _custoMedioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Adicionar lugar",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeData().primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                      _tituloController, 'Titulo', 'Insira o título'),
                  _buildDropdownPais(context),
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
              ),
            ),
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    try {
                      if (_recomendacao1Controller.text.isNotEmpty) {
                        recomedacaoSelecionada
                            .add(_recomendacao1Controller.text);
                      }
                      if (_recomendacao2Controller.text.isNotEmpty) {
                        recomedacaoSelecionada
                            .add(_recomendacao2Controller.text);
                      }
                      if (_recomendacao3Controller.text.isNotEmpty) {
                        recomedacaoSelecionada
                            .add(_recomendacao3Controller.text);
                      }
                      String idLugar =
                          new DateTime.now().millisecondsSinceEpoch.toString();
                      Lugar lugarAdicionado = Lugar(
                          id: idLugar,
                          paises: [paisSelecionado!],
                          titulo: _tituloController.text,
                          imagemUrl: _imagemURLController.text,
                          recomendacoes: recomedacaoSelecionada,
                          avaliacao:
                              double.tryParse(_avaliacaoController.text)!,
                          custoMedio:
                              double.tryParse(_custoMedioController.text)!);

                      context.read<LugaresProvider>().addLugar(lugarAdicionado);
                      Navigator.of(context).pushReplacementNamed('/');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Lugar adicionado com sucesso.')));
                    } catch (e) {
                      print('Erro: $e');
                    }
                  }
                },
                child: Text('Adicionar'))
          ],
        ),
      ),
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

  Widget _buildDropdownPais(BuildContext context) {
    final paisesProvider = context.read<PaisProvider>();
    final paises = paisesProvider.paisesLista;

    if (paises.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        child: Text('Nenhum país cadastrado. Adicione países primeiro.'),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
      child: DropdownButtonFormField<String>(
        value: paisSelecionado,
        decoration: InputDecoration(
          labelText: 'País',
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[600]!),
          ),
          border: OutlineInputBorder(),
        ),
        items: paises.map((pais) {
          return DropdownMenuItem<String>(
            value: pais.titulo,
            child: Text(pais.titulo),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            paisSelecionado = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Selecione um país';
          }
          return null;
        },
      ),
    );
  }
}
