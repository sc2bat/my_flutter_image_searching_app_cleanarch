// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_history_model.freezed.dart';
part 'user_history_model.g.dart';

@freezed
class UserHistoryModel with _$UserHistoryModel {
  factory UserHistoryModel({
    @JsonKey(name: 'view_id') required int viewId,
    @JsonKey(name: 'view_user_id') required int viewUserId,
    @JsonKey(name: 'view_image_id') required int viewImageId,
    @JsonKey(name: 'view_is_deleted') required bool viewIsDeleted,
  }) = _UserHistoryModel;

  factory UserHistoryModel.fromJson(Map<String, Object?> json) =>
      _$UserHistoryModelFromJson(json);
}
