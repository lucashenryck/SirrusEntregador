import 'package:deliverymanager/entidades/cliente.dart';

class Pedido {
  final int id;
  final int numero;
  final Cliente cliente;
  final String html;

  Pedido({
    required this.id,
    required this.numero,
    required this.cliente,
    required this.html,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      numero: json['numero'],
      cliente: Cliente.fromJson(json['cliente']),
      html: json['html'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'cliente': cliente.toJson(),
      'html': html,
    };
  }
}






