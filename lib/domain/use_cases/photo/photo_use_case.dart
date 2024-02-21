// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay/pixabay_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/image_repository.dart';

class PhotoUseCase {
  final PixabayRepository _pixabayRepository;
  final ImageRepository _imageRepository;
  PhotoUseCase({
    required PixabayRepository pixabayRepository,
    required ImageRepository imageRepository,
  })  : _pixabayRepository = pixabayRepository,
        _imageRepository = imageRepository;

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

  Future<Result<void>> save(List<Map<String, dynamic>> jsonPhotos) async {
    final savePhotosResult =
        await _imageRepository.savePhotosToSupabase(jsonPhotos);
    return savePhotosResult.when(
      success: (photos) {
        return const Result.success(null);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
