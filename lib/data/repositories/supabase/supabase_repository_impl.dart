import 'package:flutter/foundation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/supabase_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepositoryImpl implements SupabaseRepository {
  final supabase = Supabase.instance.client;
  @override
  Future<Result<bool>> isVerified() {
    // TODO: implement isVerified
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> requestVerify() {
    // TODO: implement requestVerify
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> signInWithEmail(email) async {
    await supabase.auth.signInWithOtp(
      email: email,
      emailRedirectTo: kIsWeb ? null : supabaseLoginCallback,
    );
    // return Result.success(data);
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> signUp(model) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
