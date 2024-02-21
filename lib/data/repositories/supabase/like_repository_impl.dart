import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
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
}
