// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_comment_model.freezed.dart';
part 'user_comment_model.g.dart';

@unfreezed
class UserCommentModel with _$UserCommentModel {
  factory UserCommentModel({
    @JsonKey(name: 'comment_id') required int commentId,
    required String content,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'image_id') required int imageId,
    @JsonKey(name: 'preview_url') required String previewUrl,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _UserCommentModel;

  factory UserCommentModel.fromJson(Map<String, Object?> json) =>
      _$UserCommentModelFromJson(json);
}
