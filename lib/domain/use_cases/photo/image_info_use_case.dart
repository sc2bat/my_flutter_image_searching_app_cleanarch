import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/image_repository.dart';

class ImageInfoUseCase {
  final ImageRepository _imageRepository;
  ImageInfoUseCase({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  Future<Result<Map<String, dynamic>>> fetch(int imageId) async {
    final result =
        await _imageRepository.getPhotoCountInfoFromSupabase(imageId);
    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }
}
