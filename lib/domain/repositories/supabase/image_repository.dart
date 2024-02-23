import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';

abstract interface class ImageRepository {
  Future<Result<void>> savePhotosToSupabase(
      List<Map<String, dynamic>> jsonPhotos);

  Future<Result<PhotoModel>> getSinglePhotoFromSupabase(int imageId);
}
