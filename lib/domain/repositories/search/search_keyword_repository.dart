import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';

abstract class SearchKeywordRepository {
  Future<Result<List<String>>> getKeywordList();
  Future<Result<void>> addKeyword(String keyword);
  Future<Result<void>> dropKeyword(String keyword);
  Future<Result<void>> dropAllKeyword();
}
