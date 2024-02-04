import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_state.dart';

class SearchViewModel with ChangeNotifier {
  final PhotoUseCase _photoUseCase;

  SearchViewModel({
    required PhotoUseCase photoUseCase,
  }) : _photoUseCase = photoUseCase;

  // state
  SearchState _searchState = const SearchState();
  SearchState get getSearchState => _searchState;

  List<PhotoModel> _photoList = [];

  Future<void> getPhotos(String query) async {
    _searchState = getSearchState.copyWith(isLoading: true);

    _photoList = await _photoUseCase.execute(query);

    _searchState =
        getSearchState.copyWith(isLoading: false, photos: _photoList);
    notifyListeners();
  }
}
