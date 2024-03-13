import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/user_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class SaveUserPictureUseCase {
  SaveUserPictureUseCase({required UserRepository userRepository})
      : _userRepository = userRepository;
  final UserRepository _userRepository;

  Future<void> execute(String userUuid, String userPicture) async {
    try {
      await _userRepository.updateUserField(
          userUuid, 'user_picture', userPicture);
    } catch (e) {
      logger.info('updateUserPicture 에러: $e');
    }
  }
}
