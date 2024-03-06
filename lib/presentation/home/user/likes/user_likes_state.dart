import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/likes/user_likes_model.dart';

part 'user_likes_state.freezed.dart';

@freezed
class UserLikesState with _$UserLikesState {
  const factory UserLikesState({
    @Default(false) bool isLoading,
    @Default([]) List<UserLikesModel> userLikesList,
    @Default(false) bool isSelectMode,
    @Default([]) List<int> selectedImageList,
    @Default(false) bool isLongPressed,
    @Default(false) bool isLongPressedAfter,
    @Default(-1) int selectedIndex,
    @Default([]) List<PhotoModel> photoList,

  }) = _UserLikesState;
}