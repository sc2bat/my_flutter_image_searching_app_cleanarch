import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.freezed.dart';
part 'image_model.g.dart';

@unfreezed
class ImageModel with _$ImageModel {
  factory ImageModel({
    @JsonKey(name: 'image_id') required int imageId,
    @JsonKey(name: 'page_url') String? pageUrl,
    String? type,
    String? tags,
    @JsonKey(name: 'preview_url') String? previewUrl,
    @JsonKey(name: 'preview_width') num? previewWidth,
    @JsonKey(name: 'preview_height') num? previewHeight,
    @JsonKey(name: 'webformat_url') String? webformatUrl,
    @JsonKey(name: 'webformat_width') num? webformatWidth,
    @JsonKey(name: 'webformat_height') num? webformatHeight,
    @JsonKey(name: 'large_image_url') String? largeImageUrl,
    @JsonKey(name: 'image_width') num? imageWidth,
    @JsonKey(name: 'image_height') num? imageHeight,
    @JsonKey(name: 'image_size') num? imageSize,
    @JsonKey(name: 'upload_user_id') int? uploadUserId,
    @JsonKey(name: 'upload_user_name') String? uploadUserName,
    @JsonKey(name: 'upload_profile_user_image_url')
    String? uploadProfileUserImageUrl,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'is_deleted') bool? isDeleted,
    @JsonKey(name: 'popularity_score') int? popularityScore,
  }) = _ImageModel;

  factory ImageModel.fromJson(Map<String, Object?> json) =>
      _$ImageModelFromJson(json);
}
