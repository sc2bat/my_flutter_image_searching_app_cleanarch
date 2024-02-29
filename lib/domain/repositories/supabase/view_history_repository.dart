import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user_history/user_history_model.dart';

abstract interface class ViewHistoryRepository {
  Future<Result<void>> insert(int imageId, int userId);
  Future<Result<void>> delete(List<int> imageIdList, int userId);
  Future<Result<List<UserHistoryModel>>> getUserHistoryList(int userId);
}
