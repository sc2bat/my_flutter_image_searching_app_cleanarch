import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/history/user_history_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/view_history_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';

class ViewHistoryRepositoryImpl implements ViewHistoryRepository {
  @override
  Future<Result<void>> insert(int imageId, int userId) async {
    try {
      await supabase.from(TB_VIEW_HISTORY).insert({
        'view_user_id': userId != 0 ? userId : null,
        'view_image_id': imageId,
      });
      return const Result.success(null);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<void>> deleteUserHistories(List<int> viewIds) async {
    try {
      await supabase
          .from(TB_VIEW_HISTORY)
          .update({'view_is_deleted': true})
          .eq('view_is_deleted', false)
          .filter('view_id', 'in', '(${viewIds.join(',')})');
      return const Result.success(null);
    } catch (e) {
      return Result.error('history repo impl delete 에러 $e');
    }
  }

  @override
  Future<Result<List<UserHistoryModel>>> getUserHistoryList(int userId) async {
    try {
      final List<Map<String, dynamic>> viewData = await supabase.rpc(
        FUNC_GET_USER_HISTORY,
        params: {
          'param_user_id': userId,
        },
      );

      List<UserHistoryModel> userHistoryModel = [];
      userHistoryModel =
          viewData.map((e) => UserHistoryModel.fromJson(e)).toList();
      return Result.success(userHistoryModel);
    } catch (e) {
      return Result.error('$e');
    }
  }
}
