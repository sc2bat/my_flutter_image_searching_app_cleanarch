import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/search/search_like_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/search/search_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/get_user_id_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_ui_event.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class SearchViewModel with ChangeNotifier {
  final PhotoUseCase _photoUseCase;
  final SearchLikeUseCase _searchLikeUseCase;
  final GetUserIdUseCase _getUserIdUseCase;
  final SearchUseCase _searchUseCase;

  SearchViewModel({
    required PhotoUseCase photoUseCase,
    required SearchLikeUseCase searchLikeUseCase,
    required GetUserIdUseCase getUserIdUseCase,
    required SearchUseCase searchUseCase,
  })  : _photoUseCase = photoUseCase,
        _searchLikeUseCase = searchLikeUseCase,
        _getUserIdUseCase = getUserIdUseCase,
        _searchUseCase = searchUseCase;

  // state
  SearchState _searchState = const SearchState();
  SearchState get searchState => _searchState;

  final session = supabase.auth.currentSession;

  // ui event
  final _searchUiEventStreamController = StreamController<SearchUiEvent>();
  Stream<SearchUiEvent> get getSearchUiEventStreamController =>
      _searchUiEventStreamController.stream;

  Future<void> getPhotos(String query) async {
    _searchState = searchState.copyWith(isLoading: true);
    notifyListeners();

    // await Future.delayed(const Duration(seconds: 2));
    final executeResult = await _photoUseCase.execute(query);
    executeResult.when(
      success: (photoList) async {
        // 세션 여부 판단
        if (session != null) {
          await getUserId(session!.user.id);

          if (searchState.userModel != null) {
            await getPhotoLikeList(searchState.userModel!.userId, photoList);
          }
        }

        _searchState =
            searchState.copyWith(isLoading: false, photos: photoList);

        notifyListeners();

        final saveResult =
            await _photoUseCase.save(photoList.map((e) => e.toJson()).toList());
        saveResult.when(
          success: (_) {
            _searchUiEventStreamController
                .add(const SearchUiEvent.showSnackBar('search success'));
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
        _searchState =
            searchState.copyWith(searchHistories: searchKeywordHistories);
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

  // user use case
  Future<void> getUserId(String userUuid) async {
    final result = await _getUserIdUseCase.getUserInfo(userUuid);

    result.when(
      success: (data) {
        _searchState = searchState.copyWith(userModel: data);
      },
      error: (message) {
        logger.info(message);
        throw Exception(message);
      },
    );
  }

  Future<void> getPhotoLikeList(int userId, List<PhotoModel> photoList) async {
    final result = await _searchLikeUseCase.fetch(userId, photoList);
    result.when(success: (data) {
      _searchState = searchState.copyWith(likeList: data);

      notifyListeners();
    }, error: (message) {
      logger.info(message);
      throw Exception(message);
    });
  }

  Future<void> updateLike(LikeModel? likeModel) async {
    if (likeModel != null) {
      List<LikeModel> likeList = List.from(searchState.likeList);
      final result = await _searchLikeUseCase.updateLike(likeModel);

      result.when(
          success: (data) {
            for (var element in likeList) {
              if (element.likeId == data.likeId) {
                element.isLiked = data.isLiked;
              }
            }
            _searchState = searchState.copyWith(likeList: likeList);
            notifyListeners();

            String likeReulstMessage =
                data.isLiked ? 'like success' : 'dislike success';
            _searchUiEventStreamController
                .add(SearchUiEvent.showSnackBar(likeReulstMessage));
          },
          error: (error) => _searchUiEventStreamController
              .add(SearchUiEvent.showSnackBar(error)));
    }
  }

  Future<void> updateLikeState(LikeModel? likeModel) async {
    logger.info('qwerasdf updateLike');
    if (likeModel != null) {
      List<LikeModel> likeList = List.from(searchState.likeList);
      for (var element in likeList) {
        if (element.likeId == likeModel.likeId) {
          element.isLiked = likeModel.isLiked;
        }
      }
      _searchState = searchState.copyWith(likeList: likeList);
      notifyListeners();
    }
  }

  LikeModel? getLikeModelByImageId(int imageId) {
    if (searchState.likeList.isNotEmpty) {
      return searchState.likeList
          .firstWhere((element) => element.likeImageId == imageId);
    } else {
      return null;
    }
  }
}
