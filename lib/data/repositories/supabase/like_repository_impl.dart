import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/like_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class LikeRepositoryImpl implements LikeRepository {
  @override
  Future<Result<List<Map<String, dynamic>>>> getPopularPhotos() async {
    try {
      final List<Map<String, dynamic>> data =
          await supabase.rpc('get_popular_image_count');
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
        await supabase
            .from(TB_LIKE_HISTORY)
            .insert({'like_user_id': userId, 'like_image_id': imageId});
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
  Future<Result<void>> handleLike(Map<String, dynamic> jsonLike) async {
    try {
      await supabase.from(TB_LIKE_HISTORY).upsert(
            jsonLike,
            onConflict: 'like_id',
          );
      return const Result.success(null);
    } catch (e) {
      return Result.error('$e');
    }
  }
}
