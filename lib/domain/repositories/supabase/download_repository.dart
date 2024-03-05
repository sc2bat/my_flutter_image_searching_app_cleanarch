import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/download/user_download_model.dart';

abstract interface class DownloadRepository {
  Future<Result<void>> insertDownloadHistory(
      int userId, int imageId, String imageSize, String fileName);
  Future<Result<int>> deleteDownloadHistory(List<int> downloadIdList);
  Future<Result<List<UserDownloadModel>>> getPaginatedUserDownloadList(
      int userId, int offsetVal);
}
