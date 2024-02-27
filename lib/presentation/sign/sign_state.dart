import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_state.freezed.dart';

@freezed
class SignState with _$SignState {
  const factory SignState({
    @Default('') String userEmail,
    @Default('') String userUuid,
    @Default(false) bool isLoading,
    @Default(false) bool redirecting,
    @Default('SING IN') String buttonString,
  }) = _SignState;
}
