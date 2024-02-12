import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_ui_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchViewModel with ChangeNotifier {
  final PhotoUseCase _photoUseCase;

  SearchViewModel({
    required PhotoUseCase photoUseCase,
  }) : _photoUseCase = photoUseCase;

  // state
  SearchState _searchState = const SearchState();
  SearchState get getSearchState => _searchState;

  // ui event
  final _searchUiEventStreamController = StreamController<SearchUiEvent>();
  Stream<SearchUiEvent> get getSearchUiEventStreamController =>
      _searchUiEventStreamController.stream;

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
        _searchUiEventStreamController.add(SearchUiEvent.showSnackBar(message));
      },
    );
  }

  Future<List<String>> getSearchHistories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? searchHistories =
        prefs.getStringList('searchHistories');
    return searchHistories ?? [];
  }

  Future<void> addSearchHistories(String keyword) async {
    List<String> searchHistories = await getSearchHistories();

    Set<String> setSearchHistries = searchHistories.toSet();

    setSearchHistries.add(keyword);

    searchHistories = setSearchHistries.toList();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistories', searchHistories);
  }

  Future<void> removeSearchHistories(String keyword) async {
    List<String> searchHistories = await getSearchHistories();
    searchHistories.remove(keyword);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistories', searchHistories);
  }

  Future<void> removeAllSearchHistories(String keyword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistories', []);
  }
}
