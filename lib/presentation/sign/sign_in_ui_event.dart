import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_ui_event.freezed.dart';

@freezed
abstract class SignInUiEvent<T> with _$SignInUiEvent<T> {
  const factory SignInUiEvent.showSnackBar(String message) = ShowSnackBar;
}
