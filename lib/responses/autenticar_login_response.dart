import 'package:deliverymanager/entidades/entregador.dart';

class AutenticarLoginResponse {
  final bool success;
  final Entregador? entregador;
  final String? message;

  AutenticarLoginResponse({
    required this.success,
    this.entregador,
    this.message
  });

  factory AutenticarLoginResponse.fromJson(Map<String, dynamic> json) {
    return AutenticarLoginResponse(
      success: json['success'],
      entregador: json['entregador'] != null ? Entregador.fromJson(json['entregador']) : null,
      message: json['message'],
    );
  }
}