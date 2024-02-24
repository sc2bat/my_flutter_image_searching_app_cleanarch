import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/like/like_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class DetailViewModel with ChangeNotifier {
  final PhotoUseCase _photoUseCase;
  final LikeUseCase _likeUseCase;

  DetailViewModel({
    required PhotoUseCase photoUseCase,
    required LikeUseCase likeUseCase,
  })  : _photoUseCase = photoUseCase,
        _likeUseCase = likeUseCase;

  // state
  DetailState _detailState = const DetailState();
  DetailState get detailState => _detailState;

  Future<void> init(int userId, int imageId) async {
    _detailState = detailState.copyWith(isLoading: true);
    notifyListeners();

    PhotoModel photoData = await getPhotoData(imageId);

    final session = supabase.auth.currentSession;
    if (session != null) {
      LikeModel isLiked = await getIsLiked(userId, imageId);
      _detailState = detailState.copyWith(
        isLoading: false,
        photo: photoData,
        isLiked: isLiked,
      );
    } else {
      _detailState = detailState.copyWith(
        isLoading: false,
        photo: photoData,
      );
    }

    notifyListeners();
  }

  // search use case
  Future<PhotoModel> getPhotoData(int imageId) async {
    final result = await _photoUseCase.fetchOne(imageId);
    return result.when(
      success: (data) {
        return data;
      },
      error: (message) {
        logger.info(message);
        throw Exception(e);
      },
    );
  }

  // view use case

  // comment use case

  // download use case

  // share use case

  // like use case
  Future<LikeModel> getIsLiked(int userId, int imageId) async {
    final result = await _likeUseCase.fetch(userId, imageId);
    return result.when(
      success: (data) => data,
      error: (message) {
        logger.info(message);
        throw Exception(e);
      },
    );
  }

  Future<void> updateIsLiked(LikeModel likeModel) async {
    final result = await _likeUseCase.handleLike(likeModel);
    result.when(
      success: (data) {
        return null;
      },
      error: (message) {
        logger.info(message);
        return null;
      },
    );
  }
}
