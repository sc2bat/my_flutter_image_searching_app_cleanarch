import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/comment/comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/comment/user_comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
  test('comment paging list test', () async {
    int userId = 3;
    int offsetVal = 0;

    try {
      final List<Map<String, dynamic>> data = await supabase.rpc(
        FUNC_GET_PAGINATED_USER_COMMENTS,
        params: {
          'param_user_id': userId,
          'param_offset_val': offsetVal,
        },
      );

      List<UserCommentModel> userCommentList =
          data.map((e) => UserCommentModel.fromJson(e)).toList();

      // logger.info(userCommentList);
      expect(8, userCommentList.length);
    } catch (e) {
      logger.info(e);
    }
  });

  test('comment list test', () async {
    int userId = 3;

    try {
      final List<Map<String, dynamic>> data = await supabase.rpc(
        FUNC_GET_USER_COMMENTS,
        params: {
          'param_user_id': userId,
        },
      );

      List<UserCommentModel> userCommentList =
          data.map((e) => UserCommentModel.fromJson(e)).toList();

      logger.info(userCommentList);

      // logger.info(data);
      // logger.info(data[4]);
      // logger.info(data[4]['content']);
      // logger.info(data[4]['content'].runtimeType);
    } catch (e) {
      logger.info(e);
    }
  });

  test('supabase select popular', () async {
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
