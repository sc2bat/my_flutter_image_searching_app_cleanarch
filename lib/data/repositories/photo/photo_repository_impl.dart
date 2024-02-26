import 'package:http/http.dart' as http;
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/http.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/photo/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  @override
  Future<Result<http.Response>> getImageBytes(String imageUrl) async {
    final result = await fetchHttpData(imageUrl);
    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }
}
