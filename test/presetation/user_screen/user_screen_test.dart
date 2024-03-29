import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('get user info testing', () async {
    const userUuid = Env.testUuid;
    final supabase = SupabaseClient(
      Env.supabaseUrl,
      Env.supabaseApiKey,
    );
    final data = await supabase
        .from(TB_USER_PROFILE)
        .select()
        .eq('user_uuid', userUuid)
        .single();
    logger.info(data);
    logger.info('user_name ${data['user_name']}');
  });
}
