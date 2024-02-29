import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/tag_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class TagRepositoryImpl implements TagRepository {
  @override
  Future<Result<List<Map<String, dynamic>>>> getTagCounts() async {
    try {
      final List<Map<String, dynamic>> data =
          await supabase.rpc(FUNC_GET_TAG_COUNT);
      return Result.success(data);
    } catch (e) {
      logger.info('getTagCounts error $e');
      throw Exception('getTagCounts Exception $e');
    }
  }
}
