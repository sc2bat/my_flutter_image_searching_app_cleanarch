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
      webformatURL: photoModel.webformatURL,
      webformatWidth: photoModel.webformatWidth,
      webformatHeight: photoModel.webformatHeight,
      largeImageURL: photoModel.largeImageURL,
      fullHDURL: photoModel.fullHDURL,
      imageURL: photoModel.imageURL,
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
      webformatURL: hitDTO.webformatURL,
      webformatWidth: hitDTO.webformatWidth,
      webformatHeight: hitDTO.webformatHeight,
      largeImageURL: hitDTO.largeImageURL,
      fullHDURL: hitDTO.fullHDURL,
      imageURL: hitDTO.imageURL,
      imageWidth: hitDTO.imageWidth,
      imageHeight: hitDTO.imageHeight,
      imageSize: hitDTO.imageSize,
      uploadUserId: hitDTO.userId,
      uploadUserName: hitDTO.user,
      uploadUserImageURL: hitDTO.userImageURL,
    );
  }
}
