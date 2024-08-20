import 'package:deliverymanager/entidades/coordenada.dart';

class Cliente {
  final String nome;
  final String telefone;
  final String endereco;
  final Coordenada coordenadas;

  Cliente({
    required this.nome,
    required this.telefone,
    required this.endereco,
    required this.coordenadas,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      nome: json['nome'],
      telefone: json['telefone'],
      endereco: json['endereco'],
      coordenadas: Coordenada.fromJson(json['coordenadas']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'telefone': telefone,
      'endereco': endereco,
      'coordenadas': coordenadas.toJson(),
    };
  }
}