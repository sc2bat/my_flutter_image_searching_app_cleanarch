import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/likes/user_likes_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/like_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class UserLikesUseCase {
  final LikeRepository _likeRepository;
  UserLikesUseCase({
    required LikeRepository likeRepository,
  }) : _likeRepository = likeRepository;

  Future<Result<List<UserLikesModel>>> getUserLikesList(int userId) async {
    try {
      final result = await _likeRepository.getUserLikesList(userId);
      return result.when(
        success: (data) {
          logger.info('data print $data');
          // Sort the userLikesModel list in descending order of likeId
          final sortedUserLikesList = data
            ..sort((a, b) => b.likeId.compareTo(a.likeId));
          return Result.success(sortedUserLikesList);
        },
        error: (message) {
          return Result.error(message);
        },
      );
    } catch (e) {
      return Result.error('$e');
    }
  }

  Future<Result<void>> deleteUserLikes(List<int> likeIds) async {
    try {
      final result = await _likeRepository.deleteUserLikes(likeIds);
      return result;
    } catch (e) {
      return Result.error('deleteLikes USECASE 에러 $e');
    }
  }
}