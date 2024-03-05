import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/search/search_keyword_repository.dart';

class SearchUseCase {
  final SearchKeywordRepository _searchKeywordRepository;
  SearchUseCase({
    required SearchKeywordRepository searchKeywordRepository,
  }) : _searchKeywordRepository = searchKeywordRepository;

  Future<Result<List<String>>> getSearchKeywordList() async {
    final result = await _searchKeywordRepository.getKeywordList();

    return result.when(
      success: (data) {
        return Result.success(data);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  Future<Result<void>> addSearchKeyword(String keyword) async {
    final result = await _searchKeywordRepository.addKeyword(keyword);

    return result.when(
      success: (data) {
        return const Result.success(null);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  Future<Result<void>> dropSearchKeyword(String keyword) async {
    final result = await _searchKeywordRepository.dropKeyword(keyword);

    return result.when(
      success: (_) {
        return const Result.success(null);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  Future<Result<void>> dropAllSearchKeyword() async {
    final result = await _searchKeywordRepository.dropAllKeyword();

    return result.when(
      success: (_) {
        return const Result.success(null);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
