import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';

abstract interface class UserRepository {
  Future<Result<UserModel>> getUserInfo(String userUuid);
  Future<Result<void>> updateUserField(String userUuid, String fieldName, String newValue);
}