import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/history/user_history_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/view_history_repository.dart';

class UserHistoryUseCase {
  final ViewHistoryRepository _viewHistoryRepository;
  UserHistoryUseCase({
    required ViewHistoryRepository viewHistoryRepository,
  }) : _viewHistoryRepository = viewHistoryRepository;

  Future<Result<List<UserHistoryModel>>> getUserHistoryList(int userId) async {
    try {
      final result = await _viewHistoryRepository.getUserHistoryList(userId);
      return result.when(
        success: (data) {
          final sortedUserHistoryList = data
            ..sort((a, b) => b.viewId.compareTo(a.viewId));
          return Result.success(sortedUserHistoryList);
        },
        error: (message) {
          return Result.error(message);
        },
      );
    } catch (e) {
      return Result.error('$e');
    }
  }

  Future<Result<void>> deleteUserHistories(List<int> viewIds) async {
    try {
      final result = await _viewHistoryRepository.deleteUserHistories(viewIds);
      return result;
    } catch (e) {
      return Result.error('deleteUserHistories USECASE 에러 $e');
    }
  }
}
