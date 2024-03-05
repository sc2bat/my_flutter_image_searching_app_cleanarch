import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('user name change test', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    try {
      final result = await supabase
          .from(TB_USER_PROFILE)
          .update({
            'user_name': 'zx4031',
          })
          .eq('user_uuid', Env.testUuid)
          .select()
          .single();
      logger.info(result);
    } catch (e) {
      logger.info(e);
    }
  });
}
