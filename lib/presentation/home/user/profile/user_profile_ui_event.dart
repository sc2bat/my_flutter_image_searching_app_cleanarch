import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_ui_event.freezed.dart';

@freezed
abstract class UserProfileUiEvent<T> with _$UserProfileUiEvent<T> {
  const factory UserProfileUiEvent.showSnackBar(String message) = ShowSnackBar;
}
