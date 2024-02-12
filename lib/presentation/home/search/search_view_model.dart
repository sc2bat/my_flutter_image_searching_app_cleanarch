import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/saerch/search_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_ui_event.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class SearchViewModel with ChangeNotifier {
  final PhotoUseCase _photoUseCase;
  final SearchUseCase _searchUseCase;

  SearchViewModel({
    required PhotoUseCase photoUseCase,
    required SearchUseCase searchUseCase,
  })  : _photoUseCase = photoUseCase,
        _searchUseCase = searchUseCase;

  // state
  SearchState _searchState = const SearchState();
  SearchState get getSearchState => _searchState;

  // list
  List<PhotoModel> _photoList = [];
  List<String> _searchKeywordHistories = [];

  // ui event
  final _searchUiEventStreamController = StreamController<SearchUiEvent>();
  Stream<SearchUiEvent> get getSearchUiEventStreamController =>
      _searchUiEventStreamController.stream;

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
        _searchUiEventStreamController.add(SearchUiEvent.showSnackBar(message));
      },
    );
  }

  Future<void> getSearchHistories() async {
    final result = await _searchUseCase.getSearchKeywordList();
    result.when(
      success: (searchKeywordHistories) {
        _searchKeywordHistories = searchKeywordHistories;

        _searchState =
            getSearchState.copyWith(searchHistories: _searchKeywordHistories);
        logger.info(searchKeywordHistories.length);
        notifyListeners();
      },
      error: (message) {
        _searchUiEventStreamController.add(SearchUiEvent.showSnackBar(message));
      },
    );

    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // final List<String>? searchHistories =
    //     prefs.getStringList('searchHistories');
    // return searchHistories ?? [];
  }

  Future<void> addSearchHistories(String keyword) async {
    logger.info(keyword);
    final result = await _searchUseCase.addSearchKeyword(keyword);
    result.when(
      success: (_) {
        getSearchHistories();
      },
      error: (message) {
        _searchUiEventStreamController.add(SearchUiEvent.showSnackBar(message));
      },
    );
  }

  Future<void> removeSearchHistories(String keyword) async {
    final result = await _searchUseCase.dropSearchKeyword(keyword);
    result.when(
      success: (_) {
        getSearchHistories();
      },
      error: (message) {
        _searchUiEventStreamController.add(SearchUiEvent.showSnackBar(message));
      },
    );
  }

  Future<void> removeAllSearchHistories() async {
    final result = await _searchUseCase.dropAllSearchKeyword();
    result.when(
      success: (_) {
        getSearchHistories();
      },
      error: (message) {
        _searchUiEventStreamController.add(SearchUiEvent.showSnackBar(message));
      },
    );
  }
}
