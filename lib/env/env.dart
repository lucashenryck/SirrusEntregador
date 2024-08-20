import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField(varName: 'ANDROID_GOOGLEMAPS_APIKEY')
    static const String chaveAndroidApi = _Env.chaveAndroidApi;

    @EnviedField(varName: 'SIRRUS_API')
    static const String rotaSirrusApi = _Env.rotaSirrusApi;
}