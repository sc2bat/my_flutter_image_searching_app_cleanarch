import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/di/dependency_injection.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/routes.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  registerDependencies();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: Env.supabaseApiKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => null,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
