import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/hit_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/image_model.dart';

class ImageMapper {
  static ImageModel fromDTO(HitDTO hitDTO) {
    return ImageModel(
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
