import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/like_repository.dart';

class LikeUseCase {
  final LikeRepository _likeRepository;
  LikeUseCase({
    required LikeRepository likeRepository,
  }) : _likeRepository = likeRepository;

  Future<Result<LikeModel>> fetch(int userId, int imageId) async {
    final result = await _likeRepository.getLikeData(userId, imageId);
    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }

  Future<Result<void>> handleLike(LikeModel likeModel) async {
    final result = await _likeRepository.handleLike(likeModel.toJson());
    return result.when(
      success: (_) => const Result.success(null),
      error: (message) => Result.error(message),
    );
  }
}
