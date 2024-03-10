// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_shared_model.freezed.dart';
part 'user_shared_model.g.dart';

@freezed
class UserSharedModel with _$UserSharedModel {
  factory UserSharedModel({
    @JsonKey(name: 'share_id') required int shareId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'image_id') required int imageId,
    @JsonKey(name: 'share_is_deleted') required bool shareIsDeleted,
    @JsonKey(name: 'preview_url') required String previewUrl,
  }) = _UserSharedModel;

  factory UserSharedModel.fromJson(Map<String, Object?> json) =>
      _$UserSharedModelFromJson(json);
}