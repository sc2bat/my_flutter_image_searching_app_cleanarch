// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_model.freezed.dart';
part 'share_model.g.dart';

@unfreezed
class ShareModel with _$ShareModel {
  factory ShareModel({
    @JsonKey(name: 'share_id') required int shareId,
    @JsonKey(name: 'share_user_id') required int shareUserId,
    @JsonKey(name: 'share_image_id') required int shareImageId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'share_is_deleted') required bool isDeleted,
  }) = _ShareModel;

  factory ShareModel.fromJson(Map<String, Object?> json) =>
      _$ShareModelFromJson(json);
}
