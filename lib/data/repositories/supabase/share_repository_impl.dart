import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/shared/user_shared_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/share_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class ShareRepositoryImpl implements ShareRepository {
  @override
  Future<Result<List<Map<String, dynamic>>>> insert(
      int imageId, int userId) async {
    try {
      await supabase
          .from(TB_SHARE_HISTORY)
          .update({'share_is_deleted': true})
          .eq('share_user_id', userId)
          .eq('share_image_id', imageId)
          .eq('share_is_deleted', false);
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
  Future<Result<List<UserSharedModel>>> getUserSharedList(int userId) async {
    try {
      final List<Map<String, dynamic>> sharedData = await supabase.rpc(
        FUNC_GET_USER_SHARED,
        params: {
          'param_user_id': userId,
        },
      );
      logger.info('userId print: $userId');
      logger.info('SharedData print: $sharedData');
      List<UserSharedModel> userSharedModel = [];
      userSharedModel =
          sharedData.map((e) => UserSharedModel.fromJson(e)).toList();
      return Result.success(userSharedModel);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<void>> deleteUserShared(List<int> sharedIds) async {
    try {
      await supabase
          .from(TB_SHARE_HISTORY)
          .update({'share_is_deleted': true})
          .eq('share_is_deleted', false)
          .filter('share_id', 'in', '(${sharedIds.join(',')})');
      return const Result.success(null);
    } catch (e) {
      return Result.error('share repo impl delete 에러 $e');
    }
  }
}
