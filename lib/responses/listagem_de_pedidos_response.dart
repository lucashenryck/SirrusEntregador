import 'package:deliverymanager/entidades/pedido.dart';

class ListagemDePedidosResponse {
  final bool success;
  final List<Pedido>? pedidos;
  final String? message;

  ListagemDePedidosResponse({
    required this.success,
    this.pedidos,
    this.message
  });

  factory ListagemDePedidosResponse.fromJson(Map<String, dynamic> json) {
    List<Pedido>? listaDePedidos;
    
    if (json['pedidos'] != null) {
      if ((json['pedidos'] as List).isNotEmpty) {
        listaDePedidos = [];
        json['pedidos'].forEach((pedidoJson) {
          listaDePedidos!.add(Pedido.fromJson(pedidoJson));
        });
      } else {
        listaDePedidos = [];
      }
    }
    return ListagemDePedidosResponse(
      success: json['success'],
      pedidos: listaDePedidos,
      message: json['message']
    );
  }
}