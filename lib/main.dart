import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/di/get_it.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/routes.dart';
import 'package:provider/provider.dart';

void main() {
  registerDependencies();
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
