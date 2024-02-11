import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class SupabaseDB {
  Future<void> supabaseSelect() async {
    final data = await supabase.from(TB_USER_PROFILE).select();
    logger.info(data);
  }
}
