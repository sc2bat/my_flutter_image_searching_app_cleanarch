import 'package:http/http.dart' as http;
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/pixabay.dart';

abstract class PixabayApiRepository {
  Future<List<Hit>> getPixabayImages(String query);
  Future<List<Hit>> getPixabayImagesTest(String query, {http.Client? client});
}
