import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('_likeRepositoryImpl getLikeData', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    int userId = 1;
    int imageId = 5535486;
    Map<String, dynamic> data = {};

    final countData = await supabase
        .from(TB_LIKE_HISTORY)
        .select()
        .eq('like_user_id', userId)
        .eq('like_image_id', imageId)
        .count();
    int count = countData.count;

    logger.info(count);

    if (count == 0) {
      await supabase
          .from(TB_LIKE_HISTORY)
          .insert({'like_user_id': userId, 'like_image_id': imageId});
    }
    data = await supabase
        .from(TB_LIKE_HISTORY)
        .select()
        .eq('like_user_id', userId)
        .eq('like_image_id', imageId)
        .single();

    logger.info(data);
  });
}
