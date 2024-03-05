import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/history/user_history_model.dart';

part 'user_history_state.freezed.dart';

@freezed
class UserHistoryState with _$UserHistoryState {
  const factory UserHistoryState({
    @Default(false) bool isLoading,
    @Default([]) List<UserHistoryModel> userHistoryList,
    @Default(false) bool isSelectMode,
    @Default([]) List<int> selectedImageList,
    @Default(false) bool isLongPressed,
    @Default(false) bool isLongPressedAfter,
    @Default(-1) int selectedIndex,
    @Default([]) List<PhotoModel> photoList,

  }) = _UserHistoryState;
}