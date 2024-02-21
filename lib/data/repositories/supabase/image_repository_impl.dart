import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/image_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class ImageRepositoryImpl implements ImageRepository {
  @override
  Future<Result<void>> savePhotosToSupabase(
      List<Map<String, dynamic>> jsonPhotos) async {
    try {
      await supabase
          .from(TB_IMAGE_INFO)
          .upsert(jsonPhotos, onConflict: 'image_id');
      return const Result.success(null);
    } catch (e) {
      logger.info('savePhotosToSupabase error $e');
      throw Exception('savePhotosToSupabase Exception $e');
    }
  }

  @override
  Future<Result<void>> topSearchesFromSupabase(
      List<Map<String, dynamic>> jsonPhotos) async {
    try {
      await supabase
          .rpc('get_tag_counts');
      return const Result.success(null);
    } catch (e) {
      logger.info('topSearchesFromSupabase error $e');
      throw Exception('topSearchesFromSupabase Exception $e');
    }
  }
}
