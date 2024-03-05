// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_history_model.freezed.dart';
part 'user_history_model.g.dart';

@freezed
class UserHistoryModel with _$UserHistoryModel {
  factory UserHistoryModel({
    @JsonKey(name: 'view_id') required int viewId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'image_id') required int imageId,
    @JsonKey(name: 'view_is_deleted') required bool viewIsDeleted,
    @JsonKey(name: 'preview_url') required String previewUrl,
  }) = _UserHistoryModel;

  factory UserHistoryModel.fromJson(Map<String, Object?> json) =>
      _$UserHistoryModelFromJson(json);
}
