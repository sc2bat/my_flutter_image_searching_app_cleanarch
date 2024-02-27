import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/sign/sign_in_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/sign/sign_out_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/sign/sign_in_ui_event.dart';
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

  // sign in ui event
  final _signInUiEventStreamController = StreamController<SignInUiEvent>();
  Stream<SignInUiEvent> get signInUiEventStreamController =>
      _signInUiEventStreamController.stream;

  void _updateIsLoading(bool isLoading) {
    _signState = signState.copyWith(isLoading: isLoading);
    notifyListeners();
  }

  void _updateButtonString(String buttonString) {
    _signState = signState.copyWith(buttonString: buttonString);
    notifyListeners();
  }

  void updateRedirecting() {
    _signState = signState.copyWith(redirecting: !signState.redirecting);
    notifyListeners();
  }

  void showSnackBar(String message) {
    _signInUiEventStreamController.add(SignInUiEvent.showSnackBar(message));
  }

  // 로그인할 때마다 멩메일 인증으로 로인인 하기에 불필요
  // Future<void> signUp() async {
  //   _updateIsLoading();
  //   _updateIsLoading();
  // }

  bool emailValidator(String email) {
    if (email.isEmpty) {
      // logger.info('bool emailValidator email.isEmpty');
      showSnackBar('Please enter your email');
      return false;
    } else if (!EmailValidator.validate(email)) {
      // logger.info('bool emailValidator EmailValidator.validate(email)');
      showSnackBar('Invalid email format $email');
      return false;
    } else {
      // logger.info('올바른 이메일 형식 $email');
      return true;
    }
  }

  void changeTextField() {
    _updateIsLoading(false);
    _updateButtonString('SIGN IN');
  }

  Future<bool> signIn(String email) async {
    _updateButtonString('Loading...');
    _updateIsLoading(true);
    final result = await _signInUseCase.signInWithEmail(email);
    return result.when(success: (_) {
      return true;
    }, error: (error) {
      showSnackBar(error);
      return false;
    });
  }

  void isMounted() {
    showSnackBar('Check your email for a signIn link!');
    _updateButtonString('Check Email');
  }

  Future<void> signOut() async {
    _updateIsLoading(true);
    _updateIsLoading(false);
  }
}
