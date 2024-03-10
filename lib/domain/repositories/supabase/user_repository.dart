import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';

abstract interface class UserRepository {
  Future<Result<UserModel>> getUserInfo(String userUuid);
  Future<Result<void>> updateUserName(String userUuid, String newUserName);
  Future<Result<void>> updateUserBio(String userUuid, String newUserBio);
  Future<Result<void>> updateUserPicture(String userUuid, String newUserPicture);
}