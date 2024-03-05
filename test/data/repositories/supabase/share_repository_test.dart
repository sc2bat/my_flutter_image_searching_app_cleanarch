import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('share list select test by userid', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);

    int userId = 1;
    try {
      final result = await supabase
          .from(TB_SHARE_HISTORY)
          .select()
          .eq('share_user_id', userId)
          .eq('share_is_deleted', false);
      logger.info(result);
      logger.info(result.length);
    } catch (e) {
      logger.info('$e');
    }
  });
}
