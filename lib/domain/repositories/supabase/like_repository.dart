import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/likes/user_likes_model.dart';

abstract interface class LikeRepository {
  Future<Result<List<Map<String, dynamic>>>> getPopularPhotos();
  Future<Result<LikeModel>> getLikeData(int userId, int imageId);
  Future<Result<Map<String, dynamic>>> handleLike(
      Map<String, dynamic> jsonLike);
  Future<Result<int>> getLikeCount(int imageId);

  Future<Result<void>> deleteUserLikes(List<int> likeIds);
  Future<Result<List<UserLikesModel>>> getUserLikesList(int userId);
}
