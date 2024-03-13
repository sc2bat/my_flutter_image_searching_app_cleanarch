import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/image_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class ImageRepositoryImpl implements ImageRepository {
  @override
  Future<Result<void>> savePhotosToSupabase(
      List<Map<String, dynamic>> jsonPhotos) async {
    logger.info(jsonPhotos);
    try {
      await supabase
          .from(TB_IMAGE_INFO)
          .upsert(jsonPhotos, onConflict: 'image_id');
      return const Result.success(null);
    } catch (e) {
      // logger.info('savePhotosToSupabase error $e');
      // throw Exception('savePhotosToSupabase Exception $e');
      return Result.error('savePhotosToSupabase error $e');
    }
  }

  @override
  Future<Result<PhotoModel>> getSinglePhotoFromSupabase(int imageId) async {
    try {
      final data = await supabase
          .from(TB_IMAGE_INFO)
          .select()
          .eq('is_deleted', false)
          .eq('image_id', imageId)
          .single();

      return Result.success(PhotoModel.fromJson(data));
    } catch (e) {
      return Result.error('getSinglePhotoFromSupabase error $e');
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> getPhotoCountInfoFromSupabase(
      int imageId) async {
    try {
      final viewData = await supabase
          .from(TB_VIEW_HISTORY)
          .select()
          .eq('view_image_id', imageId)
          .count();

      final downloadData = await supabase
          .from(TB_DOWNLOAD_HISTORY)
          .select()
          .eq('download_image_id', imageId)
          .count();

      final shareData = await supabase
          .from(TB_SHARE_HISTORY)
          .select()
          .eq('share_image_id', imageId)
          .count();

      final Map<String, dynamic> data = {
        'view_count': viewData.count,
        'download_count': downloadData.count,
        'share_count': shareData.count,
      };

      return Result.success(data);
    } catch (e) {
      return Result.error('getPhotoCountInfoFromSupabase $e');
    }
  }

  @override
  Future<Result<List<PhotoModel>>> getRandomPhotos() async {
    try {
      final data = await supabase
          .from(TB_IMAGE_INFO)
          .select();
      data.shuffle();
      final limitData = data.take(60).toList();

      List<PhotoModel> randomPhotoModel = limitData.map((e) => PhotoModel.fromJson(e)).toList();

      return Result.success(randomPhotoModel);
    } catch (e) {
      return Result.error('getRandomPhotos error $e');
    }
  }
}
