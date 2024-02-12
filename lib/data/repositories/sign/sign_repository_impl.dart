import 'package:flutter/foundation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/supabase_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignRepositoryImpl implements SignRepository {
  @override
  Future<Result<bool>> signInWithEmail(String email) async {
    try {
      await supabase.auth.signInWithOtp(
        email: email.trim(),
        emailRedirectTo: kIsWeb ? null : supabaseLoginCallback,
      );

      return const Result.success(true);
    } on AuthException catch (error) {
      return Result.error(error.message);
    } catch (error) {
      return const Result.error('Unexpected error occurred');
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await supabase.auth.signOut();
      return const Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
