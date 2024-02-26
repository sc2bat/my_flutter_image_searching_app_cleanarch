import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/search_keyword_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchKeywordRepositoryImpl implements SearchKeywordRepository {
  @override
  Future<Result<void>> addKeyword(String keyword) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> searchHistories =
          prefs.getStringList('searchHistories') ?? [];

      if (searchHistories.contains(keyword)) {
        searchHistories.remove(keyword);
      }

      searchHistories.add(keyword);

      searchHistories = searchHistories.toSet().toList();

      if (searchHistories.length > 10) {
        searchHistories.removeAt(0);
      }

      await prefs.setStringList('searchHistories', searchHistories);

      return const Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<void>> dropKeyword(String keyword) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> searchHistories =
          prefs.getStringList('searchHistories') ?? [];

      if (searchHistories.contains(keyword)) {
        searchHistories.remove(keyword);
      }

      prefs.setStringList('searchHistories', searchHistories);

      return const Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<void>> dropAllKeyword() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setStringList('searchHistories', []);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<List<String>>> getKeywordList() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? searchHistories =
          prefs.getStringList('searchHistories') ?? [];
      return Result.success(searchHistories);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
