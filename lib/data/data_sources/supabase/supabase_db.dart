import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class SupabaseDB {
  Future<void> supabaseSelect() async {
    final data = await supabase.from(TB_USER_PROFILE).select();
    logger.info(data);
  }

  Future<void> supabaseSingleSelect() async {
    final data = await supabase.from(TB_USER_PROFILE).select().single();
    logger.info(data);
  }

  Future<void> supabaseSingleSelectWithCondition(
      String tableName, Map<String, dynamic> conditionJson) async {
    final data =
        await supabase.from(tableName).select().eq('test', 11).single();
    logger.info(data);
  }

  Future<void> supabaseSingleSelectWithConditionWithOrder(
      Map<String, dynamic> inputJson) async {
    final data = await supabase
        .from(inputJson["tableName"])
        .select()
        .eq(inputJson["conditionColumn"], inputJson["conditionValue"])
        .order(inputJson["orderColumn"]);
    logger.info(data);
  }
}
