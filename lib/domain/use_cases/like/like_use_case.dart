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

  Future<Result<LikeModel>> handleLike(LikeModel likeModel) async {
    final jsonData = likeModel.toJson();

    // logger.info('LikeUseCase handleLike');
    // logger.info(jsonData);

    final result = await _likeRepository.handleLike(jsonData);
    return result.when(
      success: (data) => Result.success(LikeModel.fromJson(data)),
      error: (message) => Result.error(message),
    );
  }

  Future<Result<int>> count(int imageId) async {
    final result = await _likeRepository.getLikeCount(imageId);
    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }
}
