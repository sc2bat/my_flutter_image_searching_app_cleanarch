import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/likes/user_likes_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/likes/user_likes_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/likes/user_likes_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class UserLikesViewModel with ChangeNotifier {
  final UserLikesUseCase _userLikesUseCase;
  final session = supabase.auth.currentSession;

  UserLikesViewModel({
    required UserLikesUseCase userLikesUseCase,
  }) : _userLikesUseCase = userLikesUseCase;

  UserLikesState _userLikesState = const UserLikesState();

  UserLikesState get userLikesState => _userLikesState;

  Future<void> init(int userId) async {
    _userLikesState = userLikesState.copyWith(isLoading: true);
    notifyListeners();

    final userLikesResult =
    await _userLikesUseCase.getUserLikesList(userId);
    userLikesResult.when(
      success: (data) {
        _userLikesState = userLikesState.copyWith(
          userLikesList: data,
        );
        logger.info('userLikesViewModel userLikesList는 $data ');
      },
      error: (message) {
        logger.info('userLikesResult error $message');
      },
    );
    logger.info('userLikesState.userLikesList는 ${userLikesState.userLikesList}');
    _userLikesState = userLikesState.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> deleteSelectedImages() async {
    final selectedLikeIds = userLikesState.selectedImageList;

    if (selectedLikeIds.isNotEmpty) {
      final deleteResult = await _userLikesUseCase.deleteUserLikes(selectedLikeIds);
      deleteResult.when(
        success: (_) {
          final List<UserLikesModel> updatedUserLikesList = userLikesState.userLikesList
              .where((likes) => !selectedLikeIds.contains(likes.likeId))
              .toList();

          // Remove deleted items from selectedLikeIds
          _userLikesState = _userLikesState.copyWith(
            userLikesList: updatedUserLikesList,
            selectedImageList: selectedLikeIds.where((id) => !updatedUserLikesList.any((likes) => likes.likeId == id)).toList(),
            isSelectMode: false,
          );

          _userLikesState = userLikesState.copyWith(
            userLikesList: updatedUserLikesList,
            isSelectMode: false,
            selectedImageList: [],
          );
          notifyListeners();
        },
        error: (message) {
          logger.info('user likes 삭제 에러: $message');
        },
      );
    }
  }

  void updateIsSelectMode() {
    _userLikesState = userLikesState.copyWith(
      isSelectMode: !userLikesState.isSelectMode,
    );
    notifyListeners();
  }

  void selectToDelete(int imageId) {
    List<int> selectToDeleteList = List.from(userLikesState.selectedImageList);

    if (selectToDeleteList.contains(imageId)) {
      selectToDeleteList.remove(imageId);
    } else {
      selectToDeleteList.add(imageId);
    }
    _userLikesState = userLikesState.copyWith(
      selectedImageList: selectToDeleteList,
    );
    notifyListeners();
  }

  void cancelImageList() {
    _userLikesState = userLikesState.copyWith(
      selectedImageList: [],
    );
    notifyListeners();
  }
}