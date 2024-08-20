class AtualizacaoDoPedidoResponse {
  final bool success;
  final String message;

  AtualizacaoDoPedidoResponse({
    required this.success,
    required this.message
  });

  factory AtualizacaoDoPedidoResponse.fromJson(Map<String, dynamic> json) {
    return AtualizacaoDoPedidoResponse(
      success: json['success'],
      message: json['message']
    );
  }
}

