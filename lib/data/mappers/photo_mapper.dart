import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/hit_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';

class PhotoMapper {
  static HitDTO toDTO(PhotoModel photoModel) {
    return HitDTO(
      id: photoModel.id,
      pageURL: photoModel.pageUrl,
      tags: photoModel.tags,
      previewURL: photoModel.previewUrl,
      previewWidth: photoModel.previewWidth,
      previewHeight: photoModel.previewHeight,
      webformatURL: photoModel.webformatUrl,
      webformatWidth: photoModel.webformatWidth,
      webformatHeight: photoModel.webformatHeight,
      largeImageURL: photoModel.largeImageUrl,
      // fullHDURL: photoModel.fullHDUrl,
      imageURL: photoModel.imageUrl,
      imageWidth: photoModel.imageWidth,
      imageHeight: photoModel.imageHeight,
      imageSize: photoModel.imageSize,
      userId: photoModel.uploadUserId,
      user: photoModel.uploadUserName,
      userImageURL: photoModel.uploadUserImageURL,
      type: '',
      views: 0,
      downloads: 0,
      likes: 0,
      comments: 0,
    );
  }

  static PhotoModel fromDTO(HitDTO hitDTO) {
    return PhotoModel(
      id: hitDTO.id,
      pageUrl: hitDTO.pageURL,
      tags: hitDTO.tags,
      previewUrl: hitDTO.previewURL,
      previewWidth: hitDTO.previewWidth,
      previewHeight: hitDTO.previewHeight,
      webformatUrl: hitDTO.webformatURL,
      webformatWidth: hitDTO.webformatWidth,
      webformatHeight: hitDTO.webformatHeight,
      largeImageUrl: hitDTO.largeImageURL,
      fullHDUrl: '',
      imageUrl: hitDTO.imageURL,
      imageWidth: hitDTO.imageWidth,
      imageHeight: hitDTO.imageHeight,
      imageSize: hitDTO.imageSize,
      uploadUserId: hitDTO.userId,
      uploadUserName: hitDTO.user,
      uploadUserImageURL: hitDTO.userImageURL,
    );
  }
}
