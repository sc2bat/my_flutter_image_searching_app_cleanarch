// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/home/popular_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_state.dart';

import '../../domain/use_cases/home/topsearch_use_case.dart';

class HomeViewModel with ChangeNotifier {
  final PopularUseCase _popularUseCase;
  final TopsearchUseCase _topsearchUseCase;

  HomeViewModel({
    required PopularUseCase popularUseCase,
    required TopsearchUseCase topsearchUseCase,
  })  : _popularUseCase = popularUseCase,
        _topsearchUseCase = topsearchUseCase;

  HomeState _homeState = const HomeState();

  HomeState get homeState => _homeState;

  final session = supabase.auth.currentSession;

  Future<void> init() async {
    await getPopulars();
    await getToptags();
  }

  Future<void> getPopulars() async {
    _homeState = homeState.copyWith(isLoading: true);
    notifyListeners();

    List<Map<String, dynamic>> popularList = [];

    final popularsResult = await _popularUseCase.fetch();

    popularsResult.when(
      success: (data) {
        popularList = data;
      },
      error: (_) {},
    );

    _homeState = homeState.copyWith(isLoading: true, populars: popularList);
    notifyListeners();
  }

  Future<void> getToptags() async {
    _homeState = homeState.copyWith(isLoading: true);
    notifyListeners();

    List<Map<String, dynamic>> topTagsList = [];

    final topTagsResult = await _topsearchUseCase.fetch();

    topTagsResult.when(
      success: (data) {
        topTagsList = data;
      },
      error: (_) {},
    );

    _homeState = homeState.copyWith(isLoading: true, topTags: topTagsList);
    notifyListeners();
  }
}
