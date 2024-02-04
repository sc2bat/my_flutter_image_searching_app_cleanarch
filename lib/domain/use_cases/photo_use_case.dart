// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay_repository.dart';

class PhotoUseCase {
  final PixabayRepository _pixabayRepository;
  PhotoUseCase({
    required PixabayRepository pixabayRepository,
  }) : _pixabayRepository = pixabayRepository;

  Future<Result<List<PhotoModel>>> execute(String query) async {
    final getPhotosResult =
        await _pixabayRepository.getPhotosByPixabaApi(query);
    return getPhotosResult.when(
      success: (photos) {
        return Result.success(photos);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
