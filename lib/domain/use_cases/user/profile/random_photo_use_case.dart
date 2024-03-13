import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/image_repository.dart';

class RandomPhotoUseCase {
  RandomPhotoUseCase({required ImageRepository imageRepository})
      : _imageRepository = imageRepository;
  final ImageRepository _imageRepository;

  Future<Result<List<PhotoModel>>> execute() async {
    final result = await _imageRepository.getRandomPhotos();
    switch (result) {
      case Success<List<PhotoModel>>():
        return Result.success(result.data);

      case Error<List<PhotoModel>>():
        return Result.error(result.message);
    }
    return const Result.error('randomphotousecase execute 에러');
  }
}
