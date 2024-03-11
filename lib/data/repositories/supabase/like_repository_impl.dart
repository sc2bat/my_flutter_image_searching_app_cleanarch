import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/likes/user_likes_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/like_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class LikeRepositoryImpl implements LikeRepository {
  @override
  Future<Result<List<Map<String, dynamic>>>> getPopularPhotos() async {
    try {
      final List<Map<String, dynamic>> data =
          await supabase.rpc(FUNC_GET_POPULAR_IMAGE_COUNT);
      return Result.success(data);
    } catch (e) {
      logger.info('getPopularPhotos error $e');
      throw Exception('getPopularPhotos Exception $e');
    }
  }

  @override
  Future<Result<LikeModel>> getLikeData(int userId, int imageId) async {
    try {
      final countData = await supabase
          .from(TB_LIKE_HISTORY)
          .select()
          .eq('like_user_id', userId)
          .eq('like_image_id', imageId)
          .count();
      int count = countData.count;

      if (count == 0) {
        await supabase.from(TB_LIKE_HISTORY).insert({
          'like_user_id': userId,
          'like_image_id': imageId,
          'is_liked': false,
        });
      }
      Map<String, dynamic> data = await supabase
          .from(TB_LIKE_HISTORY)
          .select()
          .eq('like_user_id', userId)
          .eq('like_image_id', imageId)
          .single();

      return Result.success(LikeModel.fromJson(data));
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> handleLike(
      Map<String, dynamic> jsonData) async {
    try {
      final result = await supabase
          .from(TB_LIKE_HISTORY)
          .update({
            'is_liked': !jsonData['is_liked'],
          })
          .eq('like_user_id', jsonData['like_user_id'])
          .eq('like_image_id', jsonData['like_image_id'])
          .eq('like_id', jsonData['like_id'])
          .select()
          .single();
      return Result.success(result);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<int>> getLikeCount(int imageId) async {
    try {
      final result = await supabase
          .from(TB_LIKE_HISTORY)
          .select('like_id')
          .eq('like_image_id', imageId)
          .eq('is_liked', true)
          .count();
      return Result.success(result.count);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<List<UserLikesModel>>> getUserLikesList(int userId) async {
    try {
      final List<Map<String, dynamic>> likesData = await supabase.rpc(
        FUNC_GET_USER_LIKES,
        params: {
          'param_user_id': userId,
        },
      );
      logger.info('userId print: $userId');
      logger.info('likesData print: $likesData');
      List<UserLikesModel> userLikesModel = [];
      userLikesModel =
          likesData.map((e) => UserLikesModel.fromJson(e)).toList();
      return Result.success(userLikesModel);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<void>> deleteUserLikes(List<int> likeIds) async {
    try {
      await supabase
          .from(TB_LIKE_HISTORY)
          .update({'is_liked': false})
          .eq('is_liked', true)
          .filter('like_id', 'in', '(${likeIds.join(',')})');
      return const Result.success(null);
    } catch (e) {
      return Result.error('like repo impl delete 에러 $e');
    }
  }
}
