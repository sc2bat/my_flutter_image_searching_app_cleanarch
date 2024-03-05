import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';

abstract interface class ShareRepository {
  Future<Result<void>> insert(int imageId, int userId);
  Future<Result<void>> delete(int shareId);
  Future<Result<void>> getShareList(int userId);
}
