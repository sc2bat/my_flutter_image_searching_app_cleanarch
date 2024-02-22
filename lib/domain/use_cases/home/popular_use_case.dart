import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/like_repository.dart';

class PopularUserCase {
  final LikeRepository _likeRepository;

  PopularUserCase({
    required LikeRepository likeRepository,
  }) : _likeRepository = likeRepository;

  Future<Result<List<Map<String, dynamic>>>> fetch() async {
    final popularResult = await _likeRepository.getPopularPhotos();

    return popularResult.when(
      success: (populars) {
        return Result.success(populars);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
