import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/user_repository.dart';

class UserProfileUseCase {
  final UserRepository _userRepository;

  UserProfileUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;


}
