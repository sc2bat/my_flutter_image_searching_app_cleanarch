import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/share_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';

class ShareRepositoryImpl implements ShareRepository {
  @override
  Future<Result<List<Map<String, dynamic>>>> insert(
      int imageId, int userId) async {
    try {
      final data = await supabase.from(TB_SHARE_HISTORY).insert({
        'share_user_id': userId,
        'share_image_id': imageId,
      }).select();

      return Result.success(data);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<void>> delete(int shareId) async {
    try {
      final result = await supabase
          .from(TB_LIKE_HISTORY)
          .select('like_id')
          // .eq('like_image_id', imageId)
          .eq('is_liked', true)
          .count();
      return Result.success(result.count);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<List<Map<String, dynamic>>>> getShareList(int userId) async {
    try {
      final result = await supabase
          .from(TB_SHARE_HISTORY)
          .select()
          .eq('share_user_id', userId)
          .eq('share_is_deleted', false);
      return Result.success(result);
    } catch (e) {
      return Result.error('$e');
    }
  }
}
