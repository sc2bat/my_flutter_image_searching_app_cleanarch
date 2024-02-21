import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';

abstract interface class ImageRepository {
  Future<Result<void>> savePhotosToSupabase(
      List<Map<String, dynamic>> jsonPhotos);
}
