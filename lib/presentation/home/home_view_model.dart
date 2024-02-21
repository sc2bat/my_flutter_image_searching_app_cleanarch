// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/home/popular_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_state.dart';

class HomeViewModel with ChangeNotifier {
  final PopularUserCase _popularUserCase;
  HomeViewModel({
    required PopularUserCase popularUserCase,
  }) : _popularUserCase = popularUserCase;

  HomeState _homeState = const HomeState();

  HomeState get homeState => _homeState;

  Future<void> init() async {
    getPopulars();
  }

  Future<void> getPopulars() async {
    _homeState = homeState.copyWith(isLoading: true);
    notifyListeners();

    List<Map<String, dynamic>> popularList = [];

    final popularsResult = await _popularUserCase.fetch();

    popularsResult.when(
      success: (data) {
        popularList = data;
      },
      error: (_) {},
    );

    _homeState = homeState.copyWith(
        isLoading: true, topSearchKeywords: [], populars: popularList);
    notifyListeners();
  }
}
