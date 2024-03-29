import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/di/dependency_injection.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  registerDependencies();

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseApiKey,
  );

  runApp(
    const MyApp(),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'ImageCraft',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: baseColor),
        useMaterial3: true,
      ),
    );
  }
}
