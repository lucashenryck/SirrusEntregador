import 'package:deliverymanager/api/sirrus_api.dart';
import 'package:deliverymanager/helpers/token.dart';
import 'package:deliverymanager/responses/atulizacao_do_pedido_response.dart';

class AtualizarStatusDoPedidoController {
  final SirrusApi sirrusApi;

  AtualizarStatusDoPedidoController(this.sirrusApi);

  Future<AtualizacaoDoPedidoResponse> atualizarStatusDoPedido(String? token, int pedidoId, String statusDoPedido) async {
    final token = await getToken();
    return await sirrusApi.atualizarStatusDoPedido(token, pedidoId, statusDoPedido);
  }
}