import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';

abstract class SignRepository<T> {
  Future<Result<void>> signInWithEmail(String email);
  Future<Result<void>> signOut();
  Future<Result<void>> deleteUser();
}
