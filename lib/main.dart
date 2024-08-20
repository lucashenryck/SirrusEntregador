import 'package:deliverymanager/helpers/token.dart';
import 'package:deliverymanager/views/acesso_a_localizacao.dart';
import 'package:deliverymanager/views/listagem_de_pedidos.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool estaLogado = false;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    final token = await getToken();
    if (token != null) {
      setState(() {
        estaLogado = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: estaLogado ? const ListagemDePedidos() : const AcessoDeLocalizacao(),
    );
  }
}
