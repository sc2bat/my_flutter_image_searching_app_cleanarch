import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';

abstract interface class LikeRepository {
  Future<Result<List<Map<String, dynamic>>>> getPopularPhotos();
}
