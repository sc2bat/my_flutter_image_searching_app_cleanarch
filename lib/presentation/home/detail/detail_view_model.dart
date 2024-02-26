// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/home/popular_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/like/like_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class DetailViewModel with ChangeNotifier {
  final PhotoUseCase _photoUseCase;
  final LikeUseCase _likeUseCase;
  final PopularUserCase _popularUserCase;

  DetailViewModel({
    required PhotoUseCase photoUseCase,
    required LikeUseCase likeUseCase,
    required PopularUserCase popularUserCase,
  })  : _photoUseCase = photoUseCase,
        _likeUseCase = likeUseCase,
        _popularUserCase = popularUserCase;

  // state
  DetailState _detailState = DetailState();
  DetailState get detailState => _detailState;

  final List<String> _tagList = [];
  List<String> get tagList => _tagList;

  Future<void> init(int userId, int imageId) async {
    _detailState = detailState.copyWith(isLoading: true);
    notifyListeners();

    PhotoModel photoData = await getPhotoData(imageId);

    final recommandImageList = await getRecommandImageList(imageId);

    final session = supabase.auth.currentSession;
    if (session != null) {
      LikeModel isLiked = await getIsLiked(userId, imageId);
      _detailState = detailState.copyWith(
        isLoading: false,
        photoModel: photoData,
        likeModel: isLiked,
        recommandImageList: recommandImageList,
      );
    } else {
      _detailState = detailState.copyWith(
        isLoading: false,
        photoModel: photoData,
        recommandImageList: recommandImageList,
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

  // recommand image
  Future<List<Map<String, dynamic>>> getRecommandImageList(int imageId) async {
    List<Map<String, dynamic>> imageList = [];

    final popularsResult = await _popularUserCase.fetch();

    popularsResult.when(
      success: (dataList) {
        for (var data in dataList) {
          if (data['image_id'] != imageId) {
            imageList.add(data);
          }
          if (imageList.length > 6) {
            break;
          }
        }
        return imageList;
      },
      error: (_) {},
    );
    return imageList;
  }
}
