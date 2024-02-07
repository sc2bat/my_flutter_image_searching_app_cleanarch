import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/widget/common/main_logo_text_widget.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;
  bool _redirecting = false;
  String buttonString = 'SIGN IN';
  late final TextEditingController _emailTextFieldController;
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    logger.info('start signIn');
    try {
      setState(() {
        _isLoading = true;
        buttonString = 'Loading';
      });
      await supabase.auth.signInWithOtp(
        email: _emailTextFieldController.text.trim(),
        emailRedirectTo: kIsWeb ? null : supabaseLoginCallback,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check your email for a signIn link!'),
          ),
        );
        _emailTextFieldController.clear();
      }
    } on AuthException catch (error) {
      logger.info('AuthException $error');
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      logger.info('error $error');
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          // _isLoading = false;
          buttonString = 'Check Email';
        });
      }
    }
  }

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        context.go('/home');
      }
    });
    _emailTextFieldController = TextEditingController();
    _emailTextFieldController.text = Env.testEmail;
    super.initState();
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    _emailTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              decoration: InputDecoration(
                hintText: 'Email Address',
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
              onPressed: _isLoading ? null : _signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: baseColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                buttonString,
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
