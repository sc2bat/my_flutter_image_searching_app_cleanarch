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
          Set<UserHistoryModel> userHistoryModel = {};

          for (var model in data) {
            if (!userHistoryModel.any((element) => element.imageId == model.imageId)) {
              userHistoryModel.add(model);
            }
          }
          return Result.success(userHistoryModel.toList());
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