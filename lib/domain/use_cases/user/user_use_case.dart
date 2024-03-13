import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/user_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';

class UserUseCase {
  final UserRepositoryImpl _userRepository;

  UserUseCase(this._userRepository);

  Future<UserModel> getUserInfo(String userUuid) async {
    final result = await _userRepository.getUserInfo(userUuid);

    return result.when(
      success: (userModel) => userModel,
      error: (error) => throw Exception(error),
    );
  }
}
