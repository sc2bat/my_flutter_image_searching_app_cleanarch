// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_download_model.freezed.dart';
part 'user_download_model.g.dart';

@unfreezed
class UserDownloadModel with _$UserDownloadModel {
  factory UserDownloadModel({
    @JsonKey(name: 'download_id') required int downloadId,
    @JsonKey(name: 'download_user_id') required int userId,
    @JsonKey(name: 'download_image_id') required int imageId,
    required String tags,
    @JsonKey(name: 'preview_url') required String previewUrl,
    @JsonKey(name: 'download_size') required String size,
    @JsonKey(name: 'download_file_name') required String fileName,
    @JsonKey(name: 'downloaded_at') required DateTime donwloadedAt,
  }) = _UserDownloadModel;

  factory UserDownloadModel.fromJson(Map<String, Object?> json) =>
      _$UserDownloadModelFromJson(json);
}
