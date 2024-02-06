import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';

abstract class SupabaseRepository<T> {
  Future<Result<bool>> signInWithEmail(T model);
  Future<Result<void>> signOut();
  Future<Result<void>> signUp(T model);
  Future<Result<void>> requestVerify();
  Future<Result<bool>> isVerified();

  // Future<Result<void>> resetPassword(String email);
}
