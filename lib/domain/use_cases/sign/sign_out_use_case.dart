import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/sign_repository.dart';

class SignOutUseCase {
  final SignRepository _signRepository;
  SignOutUseCase({
    required SignRepository signRepository,
  }) : _signRepository = signRepository;
}
