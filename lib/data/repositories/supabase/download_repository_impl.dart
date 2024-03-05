import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/download/user_download_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/download_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';

class DownloadRepositoryImpl implements DownloadRepository {
  @override
  Future<Result<void>> insertDownloadHistory(
      int userId, int imageId, String imageSize, String fileName) async {
    try {
      await supabase.from(TB_DOWNLOAD_HISTORY).insert({
        'download_user_id': userId,
        'download_image_id': imageId,
        'download_size': imageSize,
        'download_file_name': fileName,
      });

      return const Result.success(null);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<int>> deleteDownloadHistory(List<int> downloadIdList) async {
    int updateCount = 0;
    try {
      for (int i = 0; i < downloadIdList.length; i++) {
        final data = await supabase
            .from(TB_DOWNLOAD_HISTORY)
            .update({
              'download_is_deleted': true,
            })
            .eq('download_id', downloadIdList[i])
            .eq('download_is_deleted', false)
            .select()
            .count();
        updateCount += data.count;
      }

      return Result.success(updateCount);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<List<UserDownloadModel>>> getPaginatedUserDownloadList(
      int userId, int offsetVal) async {
    try {
      final List<Map<String, dynamic>> data = await supabase.rpc(
        FUNC_GET_PAGINATED_USER_DOWNLOAD_HISTORY,
        params: {
          'param_user_id': userId,
          'param_offset_val': offsetVal,
        },
      );

      List<UserDownloadModel> userDownloadList =
          data.map((e) => UserDownloadModel.fromJson(e)).toList();

      return Result.success(userDownloadList);
    } catch (e) {
      return Result.error('$e');
    }
  }
}
