import 'package:shared_preferences/shared_preferences.dart';

Future<void> guardarToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('entregador_token', token);
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('entregador_token');
}

Future<void> removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('entregador_token');
}
