import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/photo/hit_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';

class PhotoMapper {
  static PhotoModel fromDTO(HitDTO hitDTO) {
    return PhotoModel(
      imageId: hitDTO.id,
      pageUrl: hitDTO.pageURL,
      type: hitDTO.type,
      tags: hitDTO.tags,
      previewUrl: hitDTO.previewURL,
      previewWidth: hitDTO.previewWidth,
      previewHeight: hitDTO.previewHeight,
      webformatUrl: hitDTO.webformatURL,
      webformatWidth: hitDTO.webformatWidth,
      webformatHeight: hitDTO.webformatHeight,
      largeImageUrl: hitDTO.largeImageURL,
      imageWidth: hitDTO.imageWidth,
      imageHeight: hitDTO.imageHeight,
      imageSize: hitDTO.imageSize,
      uploadUserId: hitDTO.userId,
      uploadUserName: hitDTO.user,
      uploadProfileUserImageUrl: hitDTO.userImageURL,
    );
  }
}
