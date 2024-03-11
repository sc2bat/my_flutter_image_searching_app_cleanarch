import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/shared/user_shared_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/share_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class UserSharedUseCase {
  final ShareRepository _shareRepository;
  UserSharedUseCase({
    required ShareRepository shareRepository,
  }) : _shareRepository = shareRepository;

  Future<Result<List<UserSharedModel>>> getUserSharedList(int userId) async {
    try {
      final result = await _shareRepository.getUserSharedList(userId);
      return result.when(
        success: (data) {
          logger.info('data print $data');
          // Sort the userSharedModel list in descending order of shareId
          final sortedUserSharedList = data
            ..sort((a, b) => b.shareId.compareTo(a.shareId));
          return Result.success(sortedUserSharedList);
        },
        error: (message) {
          return Result.error(message);
        },
      );
    } catch (e) {
      return Result.error('$e');
    }
  }

  Future<Result<void>> deleteUserShared(List<int> shareIds) async {
    try {
      final result = await _shareRepository.deleteUserShared(shareIds);
      return result;
    } catch (e) {
      return Result.error('deleteShared USECASE 에러 $e');
    }
  }
}
