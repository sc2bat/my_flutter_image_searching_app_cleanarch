import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/download/user_download_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/download_repository.dart';

class UserDownloadUseCase {
  final DownloadRepository _downloadRepository;
  UserDownloadUseCase({
    required DownloadRepository downloadRepository,
  }) : _downloadRepository = downloadRepository;

  Future<Result<List<UserDownloadModel>>> fetchPaginated(
      int userId, int offsetVal) async {
    final result = await _downloadRepository.getPaginatedUserDownloadList(
        userId, offsetVal);
    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }

  Future<Result<int>> deleteDownloadHistory(List<int> downloadIdList) async {
    final result =
        await _downloadRepository.deleteDownloadHistory(downloadIdList);
    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }
}
