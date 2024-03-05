// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@unfreezed
class CommentModel with _$CommentModel {
  factory CommentModel({
    @JsonKey(name: 'comment_id') required int commentId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_name') required String userName,
    @JsonKey(name: 'comment_image_id') required int imageId,
    @JsonKey(name: 'comment_content') String? content,
    @JsonKey(name: 'comment_created_at') DateTime? createdAt,
    @JsonKey(name: 'comment_is_deleted') bool? isDeleted,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, Object?> json) =>
      _$CommentModelFromJson(json);
}
