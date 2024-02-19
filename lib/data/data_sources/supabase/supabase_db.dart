import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';

class SupabaseDB {
  Future<Result<dynamic>> fetchData({
    required String tableName,
    String? selectColumn,
    List<Map<String, dynamic>>? conditionList,
    String? orderColumn,
    required bool singleOption,
  }) async {
    try {
      var data = supabase.from(tableName).select(selectColumn ?? '*');

      if (conditionList != null) {
        for (final condition in conditionList) {
          String conditionKey = condition.entries.map((e) => e.key).first;
          String conditionValue = condition.entries.map((e) => e.value).first;
          data = data..eq(conditionKey, conditionValue);
        }
      }

      if (orderColumn != null) {
        data = data..order(orderColumn);
      }
      if (singleOption) {
        data = data..single();
      }

      return Result.success(data);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
