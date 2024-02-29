// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/comment/comment_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/comment/get_comment_list_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/download/image_download_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/home/popular_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/like/like_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/get_user_id_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_ui_event.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class DetailViewModel with ChangeNotifier {
  final GetUserIdUseCase _getUserIdUseCase;
  final PhotoUseCase _photoUseCase;
  final LikeUseCase _likeUseCase;
  final PopularUserCase _popularUserCase;
  final ImageDownloadUseCase _imageDownloadUseCase;
  final GetCommentListUseCase _getCommentListUseCase;
  final CommentUseCase _commentUseCase;

  DetailViewModel({
    required GetUserIdUseCase getUserIdUseCase,
    required PhotoUseCase photoUseCase,
    required LikeUseCase likeUseCase,
    required PopularUserCase popularUserCase,
    required ImageDownloadUseCase imageDownloadUseCase,
    required GetCommentListUseCase getCommentListUseCase,
    required CommentUseCase commentUseCase,
  })  : _getUserIdUseCase = getUserIdUseCase,
        _photoUseCase = photoUseCase,
        _likeUseCase = likeUseCase,
        _popularUserCase = popularUserCase,
        _imageDownloadUseCase = imageDownloadUseCase,
        _getCommentListUseCase = getCommentListUseCase,
        _commentUseCase = commentUseCase;

  // state
  DetailState _detailState = DetailState();
  DetailState get detailState => _detailState;

  final List<String> _tagList = [];
  List<String> get tagList => _tagList;

  final session = supabase.auth.currentSession;

  // ui event
  final _detailUiEventStreamController = StreamController<DetailUiEvent>();
  Stream<DetailUiEvent> get getDetailUiEventStreamController =>
      _detailUiEventStreamController.stream;

  Future<void> init(int imageId) async {
    _detailState = detailState.copyWith(isLoading: true);

    notifyListeners();

    // 이미지 정보 조회
    await getPhotoData(imageId);
    // 이미지 좋아요 수 조회
    await getLikeCount(imageId);
    // 이미지 댓글 조회
    await getCommentList(imageId);
    // 추천 이미지 리스트 조회
    await getRecommandImageList(imageId);

    // 세션 여부 판단
    if (session != null) {
      await getUserId(session!.user.id);

      await getIsLiked(detailState.userId, imageId);
    }

    _detailState = detailState.copyWith(isLoading: false);

    notifyListeners();
  }

  // user use case
  Future<void> getUserId(String userUuid) async {
    final result = await _getUserIdUseCase.getUserInfo(userUuid);

    result.when(
      success: (data) {
        _detailState = detailState.copyWith(
          userId: data.userId,
          userName: data.userName,
        );
      },
      error: (message) {
        logger.info(message);
        throw Exception(e);
      },
    );
  }

  // search use case
  Future<void> getPhotoData(int imageId) async {
    final result = await _photoUseCase.fetchOne(imageId);
    result.when(
      success: (data) {
        _detailState = detailState.copyWith(
          photoModel: data,
        );
      },
      error: (message) {
        logger.info(message);
        throw Exception(e);
      },
    );
  }

  // view use case

  // comment use case
  Future<void> getCommentList(int imageId) async {
    final result = await _getCommentListUseCase.fetch(imageId);
    result.when(
      success: (data) {
        _detailState = detailState.copyWith(commentList: data);
      },
      error: (error) {
        logger.info(error);
        throw Exception(error);
      },
    );
  }

  Future<void> insertComment(List<String> content) async {
    if (detailState.photoModel != null) {
      int imageId = detailState.photoModel!.imageId;
      final result = await _commentUseCase.insert(
        userId: detailState.userId,
        imageId: imageId,
        content: content.join('\n'),
      );

      result.when(
        success: (_) {
          _detailUiEventStreamController
              .add(DetailUiEvent.showToast('Comment posted successfully!'));
        },
        error: (error) {
          _detailUiEventStreamController.add(DetailUiEvent.showToast(error));
        },
      );

      await getCommentList(imageId);

      notifyListeners();
    } else {
      _detailUiEventStreamController.add(DetailUiEvent.showToast(
          'Please contact the administrator for assistance'));
    }
  }

  Future<void> editComment(int commentId, List<String> content) async {
    if (detailState.photoModel != null) {
      int imageId = detailState.photoModel!.imageId;
      final result = await _commentUseCase.edit(
        commentId: commentId,
        content: content.join('\n'),
      );

      result.when(
        success: (_) {
          _detailUiEventStreamController
              .add(DetailUiEvent.showToast('Comment edit successfully!'));
        },
        error: (error) {
          _detailUiEventStreamController.add(DetailUiEvent.showToast(error));
        },
      );

      await getCommentList(imageId);

      notifyListeners();
    } else {
      _detailUiEventStreamController.add(DetailUiEvent.showToast(
          'Please contact the administrator for assistance'));
    }
  }

  Future<void> deleteComment(commentId) async {
    if (detailState.photoModel != null) {
      int imageId = detailState.photoModel!.imageId;
      final result = await _commentUseCase.delete(
        commentId: commentId,
      );

      result.when(
        success: (_) {
          _detailUiEventStreamController
              .add(DetailUiEvent.showToast('Comment delete successfully!'));
        },
        error: (error) {
          _detailUiEventStreamController.add(DetailUiEvent.showToast(error));
        },
      );

      await getCommentList(imageId);

      notifyListeners();
    } else {
      _detailUiEventStreamController.add(DetailUiEvent.showToast(
          'Please contact the administrator for assistance'));
    }
  }

  // download use case
  Future<void> downloadFunction(String downloadImageUrl) async {
    final result = await _imageDownloadUseCase.saveImage(downloadImageUrl);

    result.when(
      success: (_) {
        _detailUiEventStreamController
            .add(DetailUiEvent.showToast('image download done'));
      },
      error: (error) {
        _detailUiEventStreamController.add(DetailUiEvent.showToast(error));
      },
    );
  }

  // share use case
  Future<void> shareFunction(String message) async {
    _detailUiEventStreamController.add(DetailUiEvent.showToast(message));
  }

  // like use case
  Future<void> getLikeCount(int imageId) async {
    final result = await _likeUseCase.count(imageId);
    result.when(
      success: (data) => _detailState = detailState.copyWith(likeCount: data),
      error: (message) {
        logger.info(message);
        throw Exception(e);
      },
    );
  }

  Future<void> getIsLiked(int userId, int imageId) async {
    final result = await _likeUseCase.fetch(userId, imageId);
    result.when(
      success: (data) => _detailState = detailState.copyWith(likeModel: data),
      error: (message) {
        logger.info(message);
        throw Exception(e);
      },
    );
  }

  Future<void> updateLike() async {
    if (session != null) {
      if (_detailState.likeModel != null) {
        final result = await _likeUseCase.handleLike(_detailState.likeModel!);

        result.when(
            success: (data) {
              _detailState = detailState.copyWith(likeModel: data);
              notifyListeners();
              String toastMessage = data.isLiked ? 'like' : 'dislike';
              _detailUiEventStreamController
                  .add(DetailUiEvent.showToast(toastMessage));
            },
            error: (error) => _detailUiEventStreamController
                .add(DetailUiEvent.showToast(error)));
        await getLikeCount(_detailState.likeModel!.likeImageId);
      }
      notifyListeners();
    } else {
      _detailUiEventStreamController
          .add(DetailUiEvent.showToast('The like feature requires signIn'));
    }
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

  // recommend image
  Future<void> getRecommandImageList(int imageId) async {
    List<Map<String, dynamic>> recommendImageList = [];

    final popularsResult = await _popularUserCase.fetch();

    popularsResult.when(
      success: (dataList) {
        for (var data in dataList) {
          if (data['image_id'] != imageId) {
            recommendImageList.add(data);
          }
          if (recommendImageList.length > 6) {
            break;
          }
        }

        _detailState = detailState.copyWith(
          recommendImageList: recommendImageList,
        );
      },
      error: (e) {
        logger.info(e);
        throw Exception(e);
      },
    );
  }

  // calculate image height scroll to comment list
  double calcImageHeightMoveToComment(double screenWidth) {
    if (detailState.photoModel != null &&
        detailState.photoModel!.webformatWidth != null &&
        detailState.photoModel!.webformatHeight != null) {
      double imageHeight = screenWidth *
          detailState.photoModel!.webformatHeight! /
          detailState.photoModel!.webformatWidth!
        ..round();
      return imageHeight;
    }
    return 0.0;
  }
}
