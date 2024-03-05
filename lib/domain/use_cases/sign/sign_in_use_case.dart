import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/sign_repository.dart';

class SignInUseCase {
  final SignRepository _signRepository;
  SignInUseCase({
    required SignRepository signRepository,
  }) : _signRepository = signRepository;

  Future<Result<void>> signInWithEmail(String email) async {
    final result = await _signRepository.signInWithEmail(email);
    return result.when(
      success: (_) => const Result.success(null),
      error: (error) => Result.error(error),
    );
  }
}
