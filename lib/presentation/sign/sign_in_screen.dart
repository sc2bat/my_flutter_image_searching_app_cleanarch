import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/sign/sign_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/widget/common/main_logo_text_widget.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // bool _isLoading = false;
  // final bool _redirecting = false;
  // String buttonString = 'SIGN IN';
  late final TextEditingController _emailTextFieldController;
  late final StreamSubscription<AuthState> _authStateSubscription;

  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    Future.microtask(() {
      final signViewModel = context.read<SignViewModel>();

      _streamSubscription =
          signViewModel.signInUiEventStreamController.listen((event) {
        event.when(
          showSnackBar: (message) {
            final snackBar = SnackBar(
              content: Text(message),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        );
      });

      _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
        if (signViewModel.signState.redirecting) return;
        final session = data.session;
        if (session != null) {
          signViewModel.updateRedirecting();
          // _redirecting = true;
          context.go('/home');
        }
      });
    });

    // _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
    //   if (_redirecting) return;
    //   final session = data.session;
    //   if (session != null) {
    //     _redirecting = true;
    //     context.go('/home');
    //   }
    // });
    _emailTextFieldController = TextEditingController();
    // _emailTextFieldController.text = Env.testEmail;
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _authStateSubscription.cancel();
    _emailTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SignViewModel signViewModel = context.watch();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const MainLogoTextWidget(),
            const SizedBox(
              height: 32.0,
            ),
            TextField(
              controller: _emailTextFieldController,
              onChanged: (value) {
                signViewModel.changeTextField();
              },
              decoration: InputDecoration(
                hintText: 'Enter your email address for verification',
                focusColor: baseColor,
                suffixIconColor: weakBlack,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: weakBlack,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: baseColor,
                    width: 2.0,
                  ),
                ),
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            ElevatedButton(
              onPressed: () async {
                if (!signViewModel.signState.isLoading) {
                  final email = _emailTextFieldController.text.trim();
                  _emailTextFieldController.text = email;
                  if (signViewModel.emailValidator(email)) {
                    final result = await signViewModel.signIn(email);
                    if (result && mounted) {
                      signViewModel.isMounted();
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: baseColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                signViewModel.signState.buttonString,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
