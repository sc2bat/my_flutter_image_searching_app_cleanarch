import 'package:http/http.dart' as http;
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/pixabay.dart';

abstract class PixabayApiRepository {
  Future<List<Hit>> getPixabayImages(String query);
  Future<List<Hit>> getPixabayImagesTest(String query, {http.Client? client});

  Future<List<Photo>> getPixabayPhotos(String query);
  Future<List<Photo>> getPixabayPhotosByClient(String query,
      {http.Client? client});
}
