import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/view_history_repository.dart';

class ViewHistoryUseCase {
  final ViewHistoryRepository _viewHistoryRepository;
  ViewHistoryUseCase({
    required ViewHistoryRepository viewHistoryRepository,
  }) : _viewHistoryRepository = viewHistoryRepository;

  Future<Result<void>> recordViewHistory(int imageId, int userId) async {
    try {
      final result = await _viewHistoryRepository.insert(imageId, userId);
      return result.when(
        success: (_) {
          return const Result.success(null);
        },
        error: (message) {
          return Result.error(message);
        },
      );
    } catch (e) {
      return Result.error('$e');
    }
  }
}
