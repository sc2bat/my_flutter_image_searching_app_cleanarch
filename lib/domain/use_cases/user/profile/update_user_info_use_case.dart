import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/user_repository.dart';

class UpdateUserInfoUseCase {
  UpdateUserInfoUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;
  final UserRepository _userRepository;

  Future<void> execute(String userUuid, String userName, String userBio) async {
    await _userRepository.updateUserField(userUuid, 'user_name', userName);
    await _userRepository.updateUserField(userUuid, 'user_bio', userBio);
  }
}
