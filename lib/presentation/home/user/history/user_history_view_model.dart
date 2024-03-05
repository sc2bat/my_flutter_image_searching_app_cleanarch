import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/history/user_history_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/history/user_history_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/history/user_history_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class UserHistoryViewModel with ChangeNotifier {
  final UserHistoryUseCase _userHistoryUseCase;
  final session = supabase.auth.currentSession;

  UserHistoryViewModel({
    required UserHistoryUseCase userHistoryUseCase,
  }) : _userHistoryUseCase = userHistoryUseCase;

  UserHistoryState _userHistoryState = const UserHistoryState();

  UserHistoryState get userHistoryState => _userHistoryState;

  /* List<bool> getSelectedImageList() {
    return List.generate(userHistoryState.userHistoryList.length, (_) => false);
  } */

  Future<void> init(int userId) async {
    _userHistoryState = userHistoryState.copyWith(isLoading: true);
    notifyListeners();

    final userHistoryResult =
        await _userHistoryUseCase.getUserHistoryList(userId);
    userHistoryResult.when(
        success: (data) {
          _userHistoryState = userHistoryState.copyWith(
              userHistoryList: data,
          );
        },
        error: (message) {
          logger.info('userHistoryResult 가져오는 error $message');
        },
    );
    logger.info('${userHistoryState.userHistoryList}');
    _userHistoryState = userHistoryState.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> deleteSelectedImages() async {
    final selectedViewIds = userHistoryState.selectedImageList;

    if (selectedViewIds.isNotEmpty) {
      final deleteResult = await _userHistoryUseCase.deleteUserHistories(selectedViewIds);
      deleteResult.when(
        success: (_) {
            final List<UserHistoryModel> updatedUserHistoryList = userHistoryState.userHistoryList
                .where((history) => !selectedViewIds.contains(history.viewId))
                .toList();
          /*final updatedUserHistoryList = userHistoryState.userHistoryList.map((history) {
            if (selectedViewIds.contains(history.viewId)) {
              logger.info('selectedViewIds.contains');
              return history.copyWith(viewIsDeleted: true);
            }
            return history;
          }).toList();*/
          logger.info('viewmodel delete 성공?');

          // Remove deleted items from selectedViewIds
          _userHistoryState = _userHistoryState.copyWith(
            userHistoryList: updatedUserHistoryList,
            selectedImageList: selectedViewIds.where((id) => !updatedUserHistoryList.any((history) => history.viewId == id)).toList(),
            isSelectMode: false,
          );

          _userHistoryState = userHistoryState.copyWith(
            userHistoryList: updatedUserHistoryList,
            isSelectMode: false,
            selectedImageList: [],
          );
          notifyListeners();
        },
        error: (message) {
          logger.info('user history 삭제 에러: $message');
        },
      );
    }

  }

  void updateIsSelectMode() {
    _userHistoryState = userHistoryState.copyWith(
      isSelectMode: !userHistoryState.isSelectMode,
    );
    notifyListeners();
  }

  void selectToDelete(int imageId) {
    List<int> selectToDeleteList = List.from(userHistoryState.selectedImageList);

    if (selectToDeleteList.contains(imageId)) {
      selectToDeleteList.remove(imageId);
    } else {
      selectToDeleteList.add(imageId);
    }
    _userHistoryState = userHistoryState.copyWith(
      selectedImageList: selectToDeleteList,
    );
    notifyListeners();
  }

  void cancelImageList() {
    _userHistoryState = userHistoryState.copyWith(
      selectedImageList: [],
    );
    notifyListeners();
  }
  

}
