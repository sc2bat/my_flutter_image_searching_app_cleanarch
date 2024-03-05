import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/history/user_history_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('user history list testing', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    try {
      final viewData =
          await supabase.from(TB_VIEW_HISTORY).select().eq('view_user_id', 2).eq('view_is_deleted', false);
      List<UserHistoryModel> userHistoryModel = [];
      userHistoryModel =
          viewData.map((e) => UserHistoryModel.fromJson(e)).toList();
      logger.info('userHistoryModel $userHistoryModel');
    } catch (e) {
      logger.info('user history list testing ERROR $e');
    }
  });
  test('view history insert testing', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    int userId = 0;
    try {
      final data = await supabase.from(TB_VIEW_HISTORY).insert({
        'view_user_id': userId != 0 ? userId : null,
        'view_image_id': 5535486,
      }).select();

      logger.info('DATA $data');
    } catch (e) {
      logger.info('ERROR $e');
    }
  });
  test('함수', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    try {

      final List<Map<String, dynamic>> viewData = await supabase.rpc(
        FUNC_GET_USER_HISTORY,
        params: {
          'param_user_id': 2,
        },
      );

      List<UserHistoryModel> userHistoryModel = [];
      userHistoryModel =
          viewData.map((e) => UserHistoryModel.fromJson(e)).toList();
      logger.info('userHistoryModel $userHistoryModel');
    } catch (e) {
      logger.info('user history list testing ERROR $e');
    }
  });


  test('delete함수', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    try {
      final data = await supabase
          .from(TB_VIEW_HISTORY)
          .update({'view_is_deleted': true})
          .eq('view_is_deleted', false)
          .filter('view_id', 'in', '(${[17, 18, 19].join(',')})');
      logger.info(data);
    } catch (e) {
      logger.info(e);
    }
  });
}
