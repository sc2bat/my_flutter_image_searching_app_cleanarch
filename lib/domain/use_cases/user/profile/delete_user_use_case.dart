import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/sign_repository.dart';

class DeleteUserUseCase {
  DeleteUserUseCase({
    required SignRepository signRepository,
  }) : _signRepository = signRepository;

  final SignRepository _signRepository;

  Future<Result<void>> execute() async {
    final result = await _signRepository.deleteUser();

    switch (result) {
      case Success<Result<void>>():
        return const Result.success(null);
      case Error<Result<void>>():
        return Result.error(result.message);
    }
    return const Result.error('DeleteUserUseCase Error');
  }
}
