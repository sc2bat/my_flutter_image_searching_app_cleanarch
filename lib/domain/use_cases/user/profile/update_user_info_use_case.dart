import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/user_repository.dart';

class UpdateUserInfoUseCase {
  UpdateUserInfoUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;
  final UserRepository _userRepository;

  Future<void> execute(UserModel userModel) async {
    await _userRepository.updateUserField(
        userModel.userUuid, 'user_name', userModel.userName);
    await _userRepository.updateUserField(
        userModel.userUuid, 'user_bio', userModel.userBio);
    await _userRepository.updateUserField(
        userModel.userUuid, 'user_picture', userModel.userPicture);
  }
}
