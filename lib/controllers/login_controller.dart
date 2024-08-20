import 'package:deliverymanager/api/sirrus_api.dart';
import 'package:deliverymanager/responses/login_response.dart';

class LoginController {
  final SirrusApi sirrusApi;

  LoginController(this.sirrusApi);

  Future<LoginResponse> logar(String email) async {
    return await sirrusApi.logar(email);
  }
}
