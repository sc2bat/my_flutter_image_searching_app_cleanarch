import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_state.freezed.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default(false) bool isLoading,
    @Default('') String userUuid,
    @Default('') String userName,
    @Default('') String userBio,
    @Default('') String userPicture,
  }) = _UserProfileState;
}
