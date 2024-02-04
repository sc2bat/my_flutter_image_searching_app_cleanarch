import 'dart:convert';

import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/http.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/hit_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/mappers/photo_mapper.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';

class PixabayApi {
  Future<List<PhotoModel>> getPixabayImages(String query) async {
    final response = await fetchHttpData(pixabayApiUrl + query);

    List<PhotoModel> resultPhotos = [];

    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse.containsKey('hits')) {
      resultPhotos = (jsonResponse['hits'] as List<dynamic>)
          .map((e) => PhotoMapper.fromDTO(HitDTO.fromJson(e)))
          .toList();
    }

    return resultPhotos;
  }
}
