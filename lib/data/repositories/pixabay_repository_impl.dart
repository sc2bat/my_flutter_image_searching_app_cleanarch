import 'dart:convert';
import 'dart:math';

import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/apis/pixabay_api.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/photo/hit_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/photo/pixabay_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay/pixabay_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:http/http.dart' as http;

class PixabayRepositoryImpl implements PixabayRepository {
  @override
  Future<List<HitDTO>> getPixabayImages(String query) async {
    final response = await http.get(Uri.parse(
      pixabayApiUrl + query,
    ));

    if (response.statusCode == 200) {
      // final jsonResponse = jsonDecode(response.body);
      // Iterable hits = jsonResponse['hits'];
      // return hits.map((e) => Hit.fromJson(e)).toList();

      return PixabayDTO.fromJson(
              jsonDecode(response.body) as Map<String, dynamic>)
          .hits;
    }

    throw Exception(e);
  }

  @override
  Future<List<HitDTO>> getPixabayImagesTest(String query,
      {http.Client? client}) async {
    client ??= http.Client();

    final response = await client.get(Uri.parse(
      pixabayApiUrl + query,
    ));

    if (response.statusCode == 200) {
      return PixabayDTO.fromJson(
              jsonDecode(response.body) as Map<String, dynamic>)
          .hits;
    }

    throw Exception(e);
  }

  @override
  Future<List<PhotoModel>> getPixabayPhotos(String query) async {
    final response = await http.get(Uri.parse(pixabayApiUrl + query));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey('hits')) {
        return (jsonResponse['hits'] as List<dynamic>)
            .map((e) => PhotoModel.fromJson(e))
            .toList();
      }
    }

    throw UnimplementedError();
  }

  @override
  Future<List<PhotoModel>> getPixabayPhotosByClient(String query,
      {http.Client? client}) async {
    client ??= http.Client();

    final response = await client.get(Uri.parse(
      pixabayApiUrl + query,
    ));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey('hits')) {
        return (jsonResponse['hits'] as List<dynamic>)
            .map((e) => PhotoModel.fromJson(e))
            .toList();
      }
    }

    throw Exception(e);
  }

  @override
  Future<Result<List<PhotoModel>>> getPhotosByPixabaApi(String query) async {
    final Result<List<PhotoModel>> getPixabayImagesResult =
        await PixabayApi().getPixabayImages(query);

    return getPixabayImagesResult.when(
      success: (photos) {
        return Result.success(photos);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
