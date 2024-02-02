import 'dart:convert';
import 'dart:math';

import 'package:my_flutter_image_searching_app_cleanarch/data/repository/pixabay_api_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/pixabay.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:http/http.dart' as http;

class PixabayApiRepositoryImpl implements PixabayApiRepository {
  final pixabayApiUrl = Env.pixabayApiUrl;

  @override
  Future<List<Hit>> getPixabayImages(String query) async {
    final response = await http.get(Uri.parse(
      pixabayApiUrl + query,
    ));

    if (response.statusCode == 200) {
      // final jsonResponse = jsonDecode(response.body);
      // Iterable hits = jsonResponse['hits'];
      // return hits.map((e) => Hit.fromJson(e)).toList();

      return Pixabay.fromJson(jsonDecode(response.body) as Map<String, dynamic>)
          .hits;
    }

    throw Exception(e);
  }

  @override
  Future<List<Hit>> getPixabayImagesTest(String query,
      {http.Client? client}) async {
    client ??= http.Client();

    final response = await client.get(Uri.parse(
      pixabayApiUrl + query,
    ));

    if (response.statusCode == 200) {
      // final jsonResponse = jsonDecode(response.body);
      // Iterable hits = jsonResponse['hits'];
      // return hits.map((e) => Hit.fromJson(e)).toList();

      return Pixabay.fromJson(jsonDecode(response.body) as Map<String, dynamic>)
          .hits;
    }

    throw Exception(e);
  }
}
