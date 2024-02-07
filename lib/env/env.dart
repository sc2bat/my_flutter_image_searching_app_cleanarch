// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env', useConstantCase: true)
abstract class Env {
  @EnviedField()
  static const String pixabayApiKey = _Env.pixabayApiKey;

  @EnviedField()
  static const String supabaseApiKey = _Env.supabaseApiKey;
  @EnviedField()
  static const String testEmail = _Env.testEmail;
}
