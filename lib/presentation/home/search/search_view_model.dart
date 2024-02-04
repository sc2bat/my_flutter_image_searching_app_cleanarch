import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay_repository.dart';

class SearchViewModel with ChangeNotifier {
  final PixabayRepository _pixabayApiRepository;

  SearchViewModel({
    required PixabayRepository pixabayApiRepository,
  }) : _pixabayApiRepository = pixabayApiRepository;

  List<Photo> _photoList = [];

  UnmodifiableListView<Photo> get getPhotoList =>
      UnmodifiableListView(_photoList);

  Future<void> getPixabayPhotos(String query) async {
    _photoList = await _pixabayApiRepository.getPixabayPhotos(query);
    notifyListeners();
  }
}
