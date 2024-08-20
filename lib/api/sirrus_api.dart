import 'package:deliverymanager/constantes/endpoints.dart';
import 'package:deliverymanager/responses/atulizacao_do_pedido_response.dart';
import 'package:deliverymanager/responses/login_response.dart';
import 'package:deliverymanager/responses/listagem_de_pedidos_response.dart';
import 'package:deliverymanager/responses/autenticar_login_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SirrusApi {

  Future<LoginResponse> logar(String email) async {
    final response = await http.post(
      urlLogin,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );
    return LoginResponse.fromJson(jsonDecode(response.body));
  }

  Future<AutenticarLoginResponse> validar(String email, String codigo) async {
    final response = await http.post(
      urlValidacao,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'codigo': codigo,
      }),
    );
    return AutenticarLoginResponse.fromJson(jsonDecode(response.body));
  }
  
  Future<ListagemDePedidosResponse> buscarPedidos(String? token, String latitudeDoEntregador, String longitudeDoEntregador) async {
    final response = await http.get(
      Uri.parse(urlPedidos).replace(queryParameters: {
        'token': token,
        'latitude': latitudeDoEntregador,
        'longitude': longitudeDoEntregador
      }),
    );
    return ListagemDePedidosResponse.fromJson(jsonDecode(response.body));
  }

  Future<AtualizacaoDoPedidoResponse> atualizarStatusDoPedido (String? token, int pedidoId, String statusDoPedido) async {
    final response = await http.post(
      Uri.parse('$urlPedidos/atualizar-status?token=$token'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'pedido_id': pedidoId,
        'status': statusDoPedido,
      }),
    );
    return AtualizacaoDoPedidoResponse.fromJson(jsonDecode(response.body));
  }
}