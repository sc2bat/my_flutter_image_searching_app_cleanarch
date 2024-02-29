import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';

abstract interface class ViewHistoryRepository {
  Future<Result<void>> insert(int imageId, int userId);
  Future<Result<void>> delete(List<int> imageIdList, int userId);
}
