import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignElevatedButtonWidget extends StatefulWidget {
  const SignElevatedButtonWidget({
    super.key,
  });

  @override
  State<SignElevatedButtonWidget> createState() =>
      _SignElevatedButtonWidgetState();
}

class _SignElevatedButtonWidgetState extends State<SignElevatedButtonWidget> {
  bool isSigned = false;
  String userEmail = '';

  @override
  void initState() {
    Session? session = supabase.auth.currentSession;
    User? user = session?.user;
    setState(() {
      if (user != null) {
        if (user.email != null) {
          userEmail = user.email!;
          isSigned = true;
        }
      } else {
        isSigned = false;
      }
    });
    super.initState();
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    logger.info('logout');
    setState(() {
      isSigned = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => isSigned ? signOut() : context.push('/signIn'),
      style: ElevatedButton.styleFrom(
        backgroundColor: baseColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        isSigned ? 'signOut' : 'signIn',
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
      ),
    );
  }
}
