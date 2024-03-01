import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/comment/user_comment_model.dart';

part 'user_comments_state.freezed.dart';

@freezed
class UserCommentsState with _$UserCommentsState {
  const factory UserCommentsState({
    @Default(false) bool isLoading,
    @Default(false) bool additionalLoading,
    @Default(0) int userId,
    @Default(0) int currentItemCount,
    @Default([]) List<PhotoModel> photoList,
    @Default([]) List<UserCommentModel> commentList,
  }) = _UserCommentsState;
}
