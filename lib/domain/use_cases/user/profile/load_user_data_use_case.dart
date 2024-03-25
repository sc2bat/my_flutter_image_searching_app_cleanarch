import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/user_repository.dart';

class LoadUserDataUseCase {
  LoadUserDataUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;
  final UserRepository _userRepository;

  Future<Result<UserModel>> execute(String userUuid) async {
    final result = await _userRepository.getUserInfo(userUuid);
    return result.when(
      success: (data) {
        return Result.success(data);
      },
      error: (error) {
        return Result.error(error);
      },
    );
  }
}
