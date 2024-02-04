import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/pixabay_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

void main() {
  test('getPhotosByPixabaApi testing', () async {
    final pixabayApiRepositoryImpl = PixabayRepositoryImpl();

    List<PhotoModel> photos =
        await pixabayApiRepositoryImpl.getPhotosByPixabaApi('apple');

    logger.info(photos[0]);
    // logger.info(photos[1].id);
    // logger.info(photos[2].id);
    // logger.info(photos[3].id);

    expect(photos.length, 20);
  });
}
