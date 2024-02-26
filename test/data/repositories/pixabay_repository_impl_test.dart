import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/http.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/photo/hit_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/mappers/photo_mapper.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

void main() {
  test('description', () async {
    int imageId = 5535486;
    final Result pixabayApiResult =
        await fetchHttpData('$pixabayApiById$imageId');

    pixabayApiResult.when(
      success: (response) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('hits')) {
          logger.info(jsonResponse['hits']);

          // logger.info(jsonResponse['hits'] is List<dynamic>);

          PhotoModel photoModel = PhotoMapper.fromDTO(
              HitDTO.fromJson((jsonResponse['hits'] as List<dynamic>)[0]));

          logger.info(photoModel);
        }
      },
      error: (message) {
        logger.info(message);
        // Result.error(message);
      },
    );
  });

  /**
   * 
  test('getPhotosByPixabaApi testing', () async {
    // result 적용 후 미사용

    final pixabayApiRepositoryImpl = PixabayRepositoryImpl();

    <List<PhotoModel>> photos =
        await pixabayApiRepositoryImpl.getPhotosByPixabaApi('apple');

    logger.info(photos[0]);
    logger.info(photos[1].id);
    logger.info(photos[2].id);
    logger.info(photos[3].id);

    expect(photos.length, 20);
  });

  test('PhotoUseCase test', () async {
    registerDependencies();

    final photoUseCase = getIt<PhotoUseCase>();
    List<PhotoModel> photos = await photoUseCase.execute('');

    expect(photos.length, 20);
  });
   */
}
