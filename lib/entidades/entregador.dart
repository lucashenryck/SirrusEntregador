class Entregador {
  final int id;
  final int empresaId;
  final String nome;
  final String email;
  final String status;
  final String token;

  Entregador({
    required this.id,
    required this.empresaId,
    required this.nome,
    required this.email,
    required this.status,
    required this.token,
  });

  factory Entregador.fromJson(Map<String, dynamic> json) {
    return Entregador(
      id: json['id'],
      empresaId: json['empresa_id'],
      nome: json['nome'],
      email: json['email'],
      status: json['status'],
      token: json['token'],
    );
  }
}