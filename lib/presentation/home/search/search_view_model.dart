import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

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
    notifyListeners();

    // await Future.delayed(const Duration(seconds: 2));
    final executeResult = await _photoUseCase.execute(query);
    executeResult.when(
      success: (photoList) {
        _photoList = photoList;

        _searchState =
            getSearchState.copyWith(isLoading: false, photos: _photoList);

        notifyListeners();
      },
      error: (message) {
        logger.info(message);
      },
    );
  }
}
