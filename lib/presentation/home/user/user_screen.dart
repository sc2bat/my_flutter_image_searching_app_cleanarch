import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late TextEditingController _emailTextFieldController;
  @override
  void initState() {
    _emailTextFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('sample'),
          TextField(
            controller: _emailTextFieldController,
            autofocus: true,
          ),
          ElevatedButton(
            onPressed: () => test(_emailTextFieldController.text),
            child: const Text('login'),
          ),
        ],
      ),
    );
  }
}

Future<void> test(String inputEmail) async {
  logger.info(inputEmail);
  await supabase.auth.signInWithOtp(
    email: inputEmail,
    emailRedirectTo: kIsWeb ? null : 'io.supabase.flutter://signin-callback/',
  );
}
