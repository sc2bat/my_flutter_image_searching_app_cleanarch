import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/comment/comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('supabase select popular', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);

    int imageId = 5535486;

    final List<Map<String, dynamic>> data = await supabase.rpc(
      FUNC_GET_IMAGE_COMMENT,
      params: {
        'image_id_param': imageId,
      },
    );

    logger.info(data);

    final comments = data.map((e) => CommentModel.fromJson(e)).toList();

    logger.info(comments.length);

    // expect(cnt, 0);
    // expect(data.length, 10);
  });
}
