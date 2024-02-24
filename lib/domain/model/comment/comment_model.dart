// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@unfreezed
class CommentModel with _$CommentModel {
  factory CommentModel({
    @JsonKey(name: 'comment_id') required int commentId,
    @JsonKey(name: 'comment_user_id') required int userId,
    @JsonKey(name: 'comment_image_id') required int imageId,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'is_deleted') bool? isDeleted,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, Object?> json) =>
      _$CommentModelFromJson(json);
}
