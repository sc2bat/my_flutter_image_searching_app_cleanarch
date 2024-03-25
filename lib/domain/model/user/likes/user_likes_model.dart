// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_likes_model.freezed.dart';
part 'user_likes_model.g.dart';

@freezed
class UserLikesModel with _$UserLikesModel {
  factory UserLikesModel({
    @JsonKey(name: 'like_id') required int likeId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'image_id') required int imageId,
    @JsonKey(name: 'is_liked') required bool isLiked,
    @JsonKey(name: 'preview_url') required String previewUrl,
  }) = _UserLikesModel;

  factory UserLikesModel.fromJson(Map<String, Object?> json) =>
      _$UserLikesModelFromJson(json);
}
