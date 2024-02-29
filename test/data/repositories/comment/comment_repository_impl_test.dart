import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('comment insert test', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);

    Map<String, dynamic> commentData = {
      'userId': 3,
      'imageId': 5535486,
      'content': 'nice picture \n good~~ \n awesome~!',
    };

    try {
      final data = await supabase.from(TB_USER_COMMENT).insert({
        'comment_user_id': commentData['userId'],
        'comment_image_id': commentData['imageId'],
        'comment_content': commentData['content'],
      }).select();

      logger.info(data);
    } catch (e) {
      logger.info(e);
    }
  });
  test('comment update test', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);

    Map<String, dynamic> commentData = {
      'commentId': 10,
      'content': 'nice picture \nawesome~!',
    };

    try {
      final data = await supabase
          .from(TB_USER_COMMENT)
          .update({
            'comment_content': commentData['content'],
          })
          .eq('comment_id', commentData['commentId'])
          .select();

      logger.info(data);
    } catch (e) {
      logger.info(e);
    }
  });
}
