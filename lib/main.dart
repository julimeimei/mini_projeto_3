import 'package:f05_lugares_app/provider/favoritosProvider.dart';
import 'package:f05_lugares_app/provider/lugaresProvider.dart';
import 'package:f05_lugares_app/provider/paisProvider.dart';
import 'package:f05_lugares_app/screens/abas.dart';
import 'package:f05_lugares_app/screens/adicionar_lugar.dart';
import 'package:f05_lugares_app/screens/configuracoes.dart';
import 'package:f05_lugares_app/screens/detalhes_lugar.dart';
import 'package:f05_lugares_app/screens/lista_lugares.dart';
import 'package:f05_lugares_app/screens/lugares_por_pais.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<FavoritosProvider>(
          create: (context) => FavoritosProvider()),
      ChangeNotifierProvider<LugaresProvider>(
          create: (context) => LugaresProvider()),
      ChangeNotifierProvider<PaisProvider>(create: (context) => PaisProvider()),
    ],
    child: MeuApp(),
  ));
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (ctx) => MinhasAbas(),
          '/lugaresPorPais': (ctx) => LugarPorPaisScreen(),
          '/detalheLugar': (ctx) => DetalhesLugarScreen(),
          '/configuracoes': (ctx) => ConfigracoesScreen(),
          '/adicionarLugar': (ctx) => AdicionarLugarScreen(),
          '/listaLugares': (ctx) => ListaLugaresScreen(),
        },
      );
    });
  }
}
