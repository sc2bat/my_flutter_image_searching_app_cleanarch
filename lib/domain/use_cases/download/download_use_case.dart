import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/download_repository.dart';

class DownloadUseCase {
  final DownloadRepository _downloadRepository;
  DownloadUseCase({
    required DownloadRepository downloadRepository,
  }) : _downloadRepository = downloadRepository;

  Future<Result<void>> insert(
      int userId, int imageId, String imageSize, String fileName) async {
    final result = await _downloadRepository.insertDownloadHistory(
        userId, imageId, imageSize, fileName);
    return result.when(
      success: (_) => const Result.success(null),
      error: (message) => Result.error(message),
    );
  }
}
