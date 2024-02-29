import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/user_repository.dart';

class GetUserIdUseCase {
  final UserRepository _userRepository;
  GetUserIdUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<Result<UserModel>> getUserInfo(String userUuid) async {
    final result = await _userRepository.getUserInfo(userUuid);
    return result.when(
      success: (data) => Result.success(data),
      error: (error) => Result.error(error),
    );
  }
}
