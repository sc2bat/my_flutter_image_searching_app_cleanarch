import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/search/search_use_case.dart';
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
      success: (photoList) async {
        _photoList = photoList;

        _searchState =
            getSearchState.copyWith(isLoading: false, photos: _photoList);

        notifyListeners();

        logger.info('photoList[0].imageId ${photoList[0].imageId}');

        final saveResult =
            await _photoUseCase.save(photoList.map((e) => e.toJson()).toList());
        saveResult.when(
          success: (_) {
            _searchUiEventStreamController
                .add(const SearchUiEvent.showSnackBar('save success'));
          },
          error: (message) {
            _searchUiEventStreamController
                .add(SearchUiEvent.showSnackBar(message));
          },
        );
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
      },
      error: (message) {
        _searchUiEventStreamController.add(SearchUiEvent.showSnackBar(message));
      },
    );
    notifyListeners();
  }

  Future<void> addSearchHistories(String keyword) async {
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
    notifyListeners();
    result.when(
      success: (_) {
        getSearchHistories();
        _searchUiEventStreamController
            .add(SearchUiEvent.showSnackBar('remove $keyword'));
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
