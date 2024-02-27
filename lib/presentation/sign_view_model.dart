import 'package:flutter/foundation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/sign/sign_in_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/sign/sign_out_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/sign/sign_state.dart';

class SignViewModel extends ChangeNotifier {
  //todo
  // logout
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;

  SignViewModel({
    required SignInUseCase signInUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _signInUseCase = signInUseCase,
        _signOutUseCase = signOutUseCase;

  SignState _signState = const SignState();
  SignState get signState => _signState;

  void _updateIsLoading() {
    _signState = signState.copyWith(isLoading: !signState.isLoading);
    notifyListeners();
  }

  void _updateRedirecting() {
    _signState = signState.copyWith(redirecting: !signState.redirecting);
    notifyListeners();
  }

  Future<void> signUp() async {
    _updateIsLoading();
    _updateIsLoading();
  }

  Future<void> signIn(String email) async {
    _updateIsLoading();

    await supabase.auth.signInWithOtp(
      email: email.trim(),
      emailRedirectTo: kIsWeb ? null : supabaseLoginCallback,
    );
    // if (mounted) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Check your email for a login link!'),
    //     ),
    //   );
    //   _emailTextFieldController.clear();
    // }
    _updateIsLoading();
  }

  Future<void> signOut() async {
    _updateIsLoading();
    _updateIsLoading();
  }
}
