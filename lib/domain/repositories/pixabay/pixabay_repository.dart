import 'package:http/http.dart' as http;
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/photo/hit_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';

abstract class PixabayRepository {
  Future<List<HitDTO>> getPixabayImages(String query);
  Future<List<HitDTO>> getPixabayImagesTest(String query,
      {http.Client? client});

  Future<List<PhotoModel>> getPixabayPhotos(String query);
  Future<List<PhotoModel>> getPixabayPhotosByClient(String query,
      {http.Client? client});
  Future<Result<List<PhotoModel>>> getPhotosByPixabaApi(String query);
}
