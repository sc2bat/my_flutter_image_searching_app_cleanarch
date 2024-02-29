import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/share_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class ShareUseCase {
  final ShareRepository _shareRepository;
  ShareUseCase({
    required ShareRepository shareRepository,
  }) : _shareRepository = shareRepository;

  Future<void> insert(int imageId, int userId) async {
    final result = await _shareRepository.insert(imageId, userId);
    result.when(
      success: (_) {
        logger.info('share insert success');
      },
      error: (String message) {
        logger.info('_shareRepository.insert error => $message');
      },
    );
  }
}
