import 'package:geolocator/geolocator.dart';

Future<Position> buscarLocalizacaoAtual() async {
  try {
    Position posicao = await obterLocalizacaoAtual();
    return posicao;
  } catch (e) {
    throw mensagemSemPrefixoException(e);
  }
}

Future<Position> obterLocalizacaoAtual() async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    throw Exception('Por favor, habilite a localização no dispositivo.');
  }

  LocationPermission permissao = await Geolocator.checkPermission();
  await verificarPermissao(permissao);

  return await Geolocator.getCurrentPosition();
}

Future<void> verificarPermissao(LocationPermission permissao) async {
  if (permissao == LocationPermission.denied) {
    permissao = await Geolocator.requestPermission();
    if (permissao == LocationPermission.denied) {
      await Geolocator.openAppSettings();
      throw Exception('Você precisa permitir o acesso à localização.');
    }
  }

  if (permissao == LocationPermission.deniedForever) {
    await Geolocator.openAppSettings();
    throw Exception('Você precisa permitir o acesso à localização.');
  }
}

String mensagemSemPrefixoException(dynamic e) {
  if (e is Exception) {
    return e.toString().split(":")[1].trim();
  } else {
    return 'Erro desconhecido ao obter localização.';
  }
}
