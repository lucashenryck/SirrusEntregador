import 'package:deliverymanager/env/env.dart';

const urlBase = Env.rotaSirrusApi;

final urlLogin = Uri.parse('${urlBase}login');
final urlValidacao = Uri.parse('${urlBase}login/autenticar');
const urlPedidos = '${urlBase}pedidos';