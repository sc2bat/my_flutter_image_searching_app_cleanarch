import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
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
  Future<Result<void>> delete(List<int> imageIdList, int userId) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
