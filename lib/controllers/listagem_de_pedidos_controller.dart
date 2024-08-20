import 'dart:async';
import 'package:deliverymanager/api/sirrus_api.dart';
import 'package:deliverymanager/entidades/pedido.dart';
import 'package:deliverymanager/helpers/localizacao.dart';
import 'package:deliverymanager/helpers/token.dart';
import 'package:flutter/material.dart';

class ListagemDePedidosController {
  final SirrusApi sirrusApi;
  late final StreamController<List<Pedido>?> pedidosController;
  Stream<List<Pedido>?> get pedidosStream => pedidosController.stream;
  final ValueNotifier<int> quantidadeDePedidos = ValueNotifier<int>(0);
  final ValueNotifier<String?> messagemDeErro = ValueNotifier<String?>(null);

  ListagemDePedidosController(this.sirrusApi) {
    pedidosController = StreamController<List<Pedido>?>();
  }

  Future<void> carregarPedidos() async {
    try {
      final token = await getToken();
      final posicao = await buscarLocalizacaoAtual();
      final pedidosResponse = await sirrusApi.buscarPedidos(token, posicao.latitude.toString(), posicao.longitude.toString());
      if(pedidosResponse.pedidos == null){
        pedidosController.add(null);
        messagemDeErro.value = pedidosResponse.message;
      } else {
        pedidosController.add(pedidosResponse.pedidos!);
        quantidadeDePedidos.value = pedidosResponse.pedidos!.length;
      }
    } catch (e) {
      pedidosController.addError(e.toString());
    }
  }

  void dispose() {
    pedidosController.close();
    quantidadeDePedidos.dispose();
  }
}
