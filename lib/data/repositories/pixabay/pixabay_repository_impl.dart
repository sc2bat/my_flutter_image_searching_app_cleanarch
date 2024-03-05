import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/apis/pixabay_api.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay/pixabay_repository.dart';

class PixabayRepositoryImpl implements PixabayRepository {
  @override
  Future<Result<List<PhotoModel>>> getPhotoListByPixabaApi(String query) async {
    final Result<List<PhotoModel>> getPixabayImagesResult =
        await PixabayApi().getPixabayImageList(query);

    return getPixabayImagesResult.when(
      success: (photos) {
        return Result.success(photos);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  @override
  Future<Result<PhotoModel>> getPhotoByPixabaApi(int imageId) async {
    final result = await PixabayApi().getPixabayImage(imageId);

    return result.when(
      success: (photos) {
        return Result.success(photos);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
