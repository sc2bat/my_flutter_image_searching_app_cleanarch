// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env')
abstract class Env {
  @EnviedField(varName: 'PIXABAY_API_KEY')
  static const String pixabayApiKey = _Env.pixabayApiKey;
}
