import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/shared/user_shared_model.dart';

abstract interface class ShareRepository {
  Future<Result<void>> insert(int imageId, int userId);
  Future<Result<List<UserSharedModel>>> getUserSharedList(int userId);
  Future<Result<void>> deleteUserShared(List<int> sharedIds);
}
