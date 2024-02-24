import 'dart:convert';

import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/http.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/photo/hit_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/mappers/photo_mapper.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';

class PixabayApi {
  Future<Result<List<PhotoModel>>> getPixabayImageList(String query) async {
    final Result pixabayApiResult =
        await fetchHttpData(pixabayApiByQuery + query);

    return pixabayApiResult.when(
      success: (response) {
        List<PhotoModel> resultPhotos = [];

        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('hits')) {
          resultPhotos = (jsonResponse['hits'] as List<dynamic>)
              .map((e) => PhotoMapper.fromDTO(HitDTO.fromJson(e)))
              .toList();
          return Result.success(resultPhotos);
        }

        return const Result.error('Key "hits" is not contain ');
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  Future<Result<PhotoModel>> getPixabayImage(int imageId) async {
    final Result pixabayApiResult =
        await fetchHttpData('$pixabayApiById$imageId');

    return pixabayApiResult.when(
      success: (response) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('hits')) {
          PhotoModel photoModel = PhotoMapper.fromDTO(
              HitDTO.fromJson((jsonResponse['hits'] as List<dynamic>)[0]));
          return Result.success(photoModel);
        }
        return const Result.error('Key "hits" is not contain ');
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
