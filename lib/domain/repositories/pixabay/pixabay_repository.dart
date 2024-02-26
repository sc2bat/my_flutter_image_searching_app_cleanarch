import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';

abstract class PixabayRepository {
  Future<Result<List<PhotoModel>>> getPhotoListByPixabaApi(String query);
  Future<Result<PhotoModel>> getPhotoByPixabaApi(int imageId);
}
