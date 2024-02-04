// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay_repository.dart';

class PhotoUseCase {
  final PixabayRepository _pixabayRepository;
  PhotoUseCase({
    required PixabayRepository pixabayRepository,
  }) : _pixabayRepository = pixabayRepository;

  Future<List<PhotoModel>> execute(String query) async {
    final photos = await _pixabayRepository.getPhotosByPixabaApi(query);
    return photos;
  }
}
