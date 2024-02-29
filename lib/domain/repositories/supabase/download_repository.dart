import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';

abstract interface class DownloadRepository {
  Future<Result<void>> insertDownloadHistory(
      int userId, int imageId, String imageSize, String fileName);
  Future<Result<void>> deleteDownloadHistory(int userId, List<int> imageId);
}
