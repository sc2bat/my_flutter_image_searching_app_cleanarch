import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/shared/user_shared_model.dart';

part 'user_shared_state.freezed.dart';

@freezed
class UserSharedState with _$UserSharedState {
  const factory UserSharedState({
    @Default(false) bool isLoading,
    @Default([]) List<UserSharedModel> userSharedList,
    @Default(false) bool isSelectMode,
    @Default([]) List<int> selectedImageList,
    @Default(false) bool isLongPressed,
    @Default(false) bool isLongPressedAfter,
    @Default(-1) int selectedIndex,
    @Default([]) List<PhotoModel> photoList,
  }) = _UserSharedState;
}