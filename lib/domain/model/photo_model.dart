// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
class PhotoModel with _$PhotoModel {
  factory PhotoModel({
    required int id,
    @JsonKey(name: 'pageURL') required String pageUrl,
    required String tags,
    @JsonKey(name: 'previewURL') required String previewUrl,
    required int previewWidth,
    required int previewHeight,
    @JsonKey(name: 'webformatURL') required String webformatUrl,
    required int webformatWidth,
    required int webformatHeight,
    @JsonKey(name: 'largeImageURL') required String largeImageUrl,
    @JsonKey(name: 'fullHDURL') required String fullHDUrl,
    @JsonKey(name: 'imageURL') required String imageUrl,
    required int imageWidth,
    required int imageHeight,
    required int imageSize,
    @JsonKey(name: 'userId') required int uploadUserId,
    @JsonKey(name: 'user') required String uploadUserName,
    @JsonKey(name: 'userImageURL') required String uploadUserImageURL,
  }) = _Photo;

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);
}
