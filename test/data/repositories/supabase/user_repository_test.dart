import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/user_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('updateUserName Test', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    UserRepositoryImpl userRepository = UserRepositoryImpl();
    String userId = '2'; // Replace with the actual user ID
    String newUserName =
        'NewUserName'; // Replace with the desired new user name

    // Perform the update
    // var result = await userRepository.updateUserName(userId, newUserName);

    // Check if the update was successful
    // expect(result, true);
  });
}
