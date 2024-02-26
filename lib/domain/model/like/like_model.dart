// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_model.freezed.dart';
part 'like_model.g.dart';

@unfreezed
class LikeModel with _$LikeModel {
  factory LikeModel({
    @JsonKey(name: 'like_id') required int likeId,
    @JsonKey(name: 'like_user_id') required int userId,
    @JsonKey(name: 'like_image_id') required int imageId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'is_deleted') required bool isDeleted,
  }) = _LikeModel;

  factory LikeModel.fromJson(Map<String, Object?> json) =>
      _$LikeModelFromJson(json);
}
