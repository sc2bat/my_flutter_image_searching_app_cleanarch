// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/comment/comment_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/comment/get_comment_list_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/download/download_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/download/image_download_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/home/popular_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/like/like_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/image_info_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/share/share_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/get_user_id_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/view/view_history_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_ui_event.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class DetailViewModel with ChangeNotifier {
  final GetUserIdUseCase _getUserIdUseCase;
  final PhotoUseCase _photoUseCase;
  final LikeUseCase _likeUseCase;
  final PopularUseCase _popularUseCase;
  final ImageInfoUseCase _imageInfoUseCase;
  final ImageDownloadUseCase _imageDownloadUseCase;
  final DownloadUseCase _downloadUseCase;
  final GetCommentListUseCase _getCommentListUseCase;
  final CommentUseCase _commentUseCase;
  final ShareUseCase _shareUseCase;
  final ViewHistoryUseCase _viewHistoryUseCase;

  DetailViewModel({
    required GetUserIdUseCase getUserIdUseCase,
    required PhotoUseCase photoUseCase,
    required LikeUseCase likeUseCase,
    required PopularUseCase popularUseCase,
    required ImageInfoUseCase imageInfoUseCase,
    required ImageDownloadUseCase imageDownloadUseCase,
    required DownloadUseCase downloadUseCase,
    required GetCommentListUseCase getCommentListUseCase,
    required CommentUseCase commentUseCase,
    required ShareUseCase shareUseCase,
    required ViewHistoryUseCase viewHistoryUseCase,
  })  : _getUserIdUseCase = getUserIdUseCase,
        _photoUseCase = photoUseCase,
        _likeUseCase = likeUseCase,
        _popularUseCase = popularUseCase,
        _imageInfoUseCase = imageInfoUseCase,
        _imageDownloadUseCase = imageDownloadUseCase,
        _downloadUseCase = downloadUseCase,
        _getCommentListUseCase = getCommentListUseCase,
        _commentUseCase = commentUseCase,
        _shareUseCase = shareUseCase,
        _viewHistoryUseCase = viewHistoryUseCase;

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
    await getRecommendImageList(imageId);

    // 세션 여부 판단
    if (session != null) {
      await getUserId(session!.user.id);

      await getIsLiked(detailState.userId, imageId);
    }

    // view record
    await recordViewHistory(imageId);

    // 이미지 info 카운트 조회
    await getViewDownloadShareCount(imageId);

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
          userPicture: data.userPicture,
          userBio: data.userBio,
        );
      },
      error: (message) {
        logger.info(message);
        throw Exception(message);
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
        throw Exception(message);
      },
    );
  }

  // view use case
  Future<void> recordViewHistory(int imageId) async {
    final result = await _viewHistoryUseCase.recordViewHistory(
        imageId, detailState.userId);
    result.when(
      success: (_) {
        logger.info('${detailState.photoModel!.imageId} view');
      },
      error: (error) {
        logger.info(error);
        throw Exception(error);
      },
    );
  }

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

  bool commentTextFieldValidation(List<String> content) {
    final validResult = content.every((line) => line.trim().isEmpty);
    _detailUiEventStreamController
        .add(DetailUiEvent.showToast('Please write the content'));
    return validResult;
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
  Future<void> downloadFunction(String size, String downloadImageUrl) async {
    final result = await _imageDownloadUseCase.saveImage(downloadImageUrl);

    result.when(
      success: (fileName) async {
        _detailUiEventStreamController
            .add(DetailUiEvent.showToast('image download done'));

        if (detailState.photoModel != null) {
          final downloadhistoryResult = await _downloadUseCase.insert(
            detailState.userId,
            detailState.photoModel!.imageId,
            size,
            fileName,
          );
          downloadhistoryResult.when(
            success: (_) => logger.info('donwloadHistory done'),
            error: (error) {
              _detailUiEventStreamController
                  .add(DetailUiEvent.showToast(error));
            },
          );
        }
      },
      error: (error) {
        _detailUiEventStreamController.add(DetailUiEvent.showToast(error));
      },
    );

    if (detailState.photoModel != null) {
      await getViewDownloadShareCount(detailState.photoModel!.imageId);
    }
  }

  // share use case
  void recordShareHistory() async {
    if (detailState.photoModel != null) {
      await _shareUseCase.insert(
          detailState.photoModel!.imageId, detailState.userId);
    }

    if (detailState.photoModel != null) {
      await getViewDownloadShareCount(detailState.photoModel!.imageId);
    }
  }

  Future<void> normalShowToast(String message) async {
    _detailUiEventStreamController.add(DetailUiEvent.showToast(message));

    if (detailState.photoModel != null) {
      await getViewDownloadShareCount(detailState.photoModel!.imageId);
    }
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
          .add(DetailUiEvent.showToast('Like feature requires signIn'));
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

  // image info
  Future<void> getViewDownloadShareCount(int imageId) async {
    final result = await _imageInfoUseCase.fetch(imageId);
    result.when(
      success: (data) {
        // logger.info(data);
        _detailState = detailState.copyWith(
          viewCount: data['view_count'],
          downloadCount: data['download_count'],
          shareCount: data['share_count'],
        );

        notifyListeners();
      },
      error: (error) => normalShowToast(error),
    );
  }

  // recommend image
  Future<void> getRecommendImageList(int imageId) async {
    List<Map<String, dynamic>> recommendImageList = [];

    final popularsResult = await _popularUseCase.fetch();

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
