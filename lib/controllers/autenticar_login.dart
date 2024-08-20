import 'package:deliverymanager/api/sirrus_api.dart';
import 'package:deliverymanager/helpers/token.dart';
import 'package:deliverymanager/responses/autenticar_login_response.dart';

class AutenticarLoginController {
  final SirrusApi sirrusApi;

  AutenticarLoginController(this.sirrusApi);

  Future<AutenticarLoginResponse> autenticarLogin(String email, String codigo) async {
    final response = await sirrusApi.validar(email, codigo);
    if (response.success) {
      await guardarToken(response.entregador!.token);
    }
    return response;
  }
}