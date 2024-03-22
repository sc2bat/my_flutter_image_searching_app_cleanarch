import 'package:flutter/foundation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/sign_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignRepositoryImpl implements SignRepository {
  @override
  Future<Result<void>> signInWithEmail(String email) async {
    try {
      await supabase.auth.signInWithOtp(
        email: email.trim(),
        emailRedirectTo: kIsWeb ? null : supabaseLoginCallback,
      );
      return const Result.success(null);
    } on AuthException catch (error) {
      logger.info('SignRepositoryImpl signInWithEmail AuthException $error');
      return Result.error(error.message);
    } catch (error) {
      logger.info('SignRepositoryImpl signInWithEmail error $error');
      return const Result.error('Unexpected error occurred');
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await supabase.auth.signOut();
      return const Result.success(null);
    } catch (e) {
      return Result.error('signOut error => ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> deleteUser() async {
    try {
      final currentUser = supabase.auth.currentUser;
      if (currentUser != null) {
        String userUuid = currentUser.id;
        await supabase.auth.admin.deleteUser(userUuid);

        return const Result.success(null);
      } else {
        return const Result.error('currentUser is null');
      }
    } catch (e) {
      return Result.error('deleteUser Error => $e');
    }
  }
}
