import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/download/user_download_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);

  test('download history paginated test', () async {
    int userId = 3;
    int offsetVal = 0;
    try {
      final List<Map<String, dynamic>> data = await supabase.rpc(
        FUNC_GET_PAGINATED_USER_DOWNLOAD_HISTORY,
        params: {
          'param_user_id': userId,
          'param_offset_val': offsetVal,
        },
      );

      List<UserDownloadModel> userDownlaodList =
          data.map((e) => UserDownloadModel.fromJson(e)).toList();

      logger.info(userDownlaodList[0]);

      String fileName = userDownlaodList[0].fileName.split('/').last;

      logger.info(fileName);

      expect(fileName, 'image_craft_ffebac20-ced5-1ee5-a761-65a277c2c99d.jpg');

      expect(userDownlaodList.length, 10);
    } catch (e) {
      logger.info('$e');
    }
  });
  test('download update test', () async {
    logger.info(downloadIdList.length);
    int updateCount = 0;
    try {
      for (int i = 0; i < downloadIdList.length; i++) {
        final data = await supabase
            .from(TB_DOWNLOAD_HISTORY)
            .update({
              'download_is_deleted': false,
            })
            .eq('download_id', downloadIdList[i])
            .eq('download_is_deleted', true)
            .select()
            .count();
        updateCount += data.count;
      }

      logger.info(updateCount);
    } catch (e) {
      logger.info('$e');
    }
  });
}

List<int> downloadIdList = [
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25
];
