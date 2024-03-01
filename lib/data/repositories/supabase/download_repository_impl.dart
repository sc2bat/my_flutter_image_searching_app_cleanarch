import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
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
  Future<Result<void>> deleteDownloadHistory(int userId, List<int> imageId) {
    // TODO: implement deleteDownloadHistory
    throw UnimplementedError();
  }
}
