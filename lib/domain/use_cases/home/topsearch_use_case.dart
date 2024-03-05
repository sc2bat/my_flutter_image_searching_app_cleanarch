import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/tag_repository.dart';

class TopsearchUseCase {
  final TagRepository _tagRepository;

  TopsearchUseCase({
    required TagRepository tagRepository,
  }) : _tagRepository = tagRepository;

  Future<Result<List<Map<String, dynamic>>>> fetch() async {
    final topTagsResult = await _tagRepository.getTagCounts();

    return topTagsResult.when(
      success: (topTags) {
        return Result.success(topTags);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
