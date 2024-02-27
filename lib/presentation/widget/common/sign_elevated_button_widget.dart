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
    logger.info('sign_widget_logout');
    setState(() {
      isSigned = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSigned
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: baseColor,
            ),
            onPressed: () => context.push('/home/user'),
            child: const Icon(
              Icons.account_circle,
              color: whiteColor,
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: baseColor,
            ),
            onPressed: () => //context.push('/home/user'),
         context.push('/signIn'),
            child: const Text(
              'SignOut',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
          );
  }
}
