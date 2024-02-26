import 'package:http/http.dart' as http;
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';

abstract interface class PhotoRepository {
  Future<Result<http.Response>> getImageBytes(String imageUrl);
}
