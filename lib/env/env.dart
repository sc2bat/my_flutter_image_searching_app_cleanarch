// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env', useConstantCase: true)
abstract class Env {
  // @EnviedField(varName: 'PIXABAY_API_KEY')
  // static const String pixabayApiKey = _Env.pixabayApiKey;
  @EnviedField()
  static const String pixabayApiKey = _Env.pixabayApiKey;

  @EnviedField()
  static const String pixabayApiUrl = _Env.pixabayApiUrl;

  @EnviedField()
  static const String sampleImageUrl = _Env.sampleImageUrl;
}
