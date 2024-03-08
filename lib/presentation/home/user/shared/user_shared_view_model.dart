import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/shared/user_shared_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/shared/user_shared_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/shared/user_shared_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class UserSharedViewModel with ChangeNotifier {
  final UserSharedUseCase _userSharedUseCase;
  final session = supabase.auth.currentSession;

  UserSharedViewModel({
    required UserSharedUseCase userSharedUseCase,
  }) : _userSharedUseCase = userSharedUseCase;

  UserSharedState _userSharedState = const UserSharedState();

  UserSharedState get userSharedState => _userSharedState;

  Future<void> init(int userId) async {
    _userSharedState = userSharedState.copyWith(isLoading: true);
    notifyListeners();

    final userSharedResult = await _userSharedUseCase.getUserSharedList(userId);
    userSharedResult.when(
      success: (data) {
        _userSharedState = userSharedState.copyWith(
          userSharedList: data,
        );
        logger.info('userSharedViewModel userSharedList는 $data ');
      },
      error: (message) {
        logger.info('userSharedResult error $message');
      },
    );
    logger.info(
        'userSharedState.userSharedList는 ${userSharedState.userSharedList}');
    _userSharedState = userSharedState.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> deleteSelectedImages() async {
    final selectedShareIds = userSharedState.selectedImageList;

    if (selectedShareIds.isNotEmpty) {
      final deleteResult =
          await _userSharedUseCase.deleteUserShared(selectedShareIds);
      deleteResult.when(
        success: (_) {
          final List<UserSharedModel> updatedUserSharedList = userSharedState
              .userSharedList
              .where((shared) => !selectedShareIds.contains(shared.shareId))
              .toList();

          // Remove deleted items from selectedShareIds
          _userSharedState = _userSharedState.copyWith(
            userSharedList: updatedUserSharedList,
            selectedImageList: selectedShareIds
                .where((id) => !updatedUserSharedList
                    .any((shared) => shared.shareId == id))
                .toList(),
            isSelectMode: false,
          );

          _userSharedState = userSharedState.copyWith(
            userSharedList: updatedUserSharedList,
            isSelectMode: false,
            selectedImageList: [],
          );
          notifyListeners();
        },
        error: (message) {
          logger.info('user Shared 삭제 에러: $message');
        },
      );
    }
  }

  void updateIsSelectMode() {
    _userSharedState = userSharedState.copyWith(
      isSelectMode: !userSharedState.isSelectMode,
    );
    notifyListeners();
  }

  void selectToDelete(int imageId) {
    List<int> selectToDeleteList = List.from(userSharedState.selectedImageList);

    if (selectToDeleteList.contains(imageId)) {
      selectToDeleteList.remove(imageId);
    } else {
      selectToDeleteList.add(imageId);
    }
    _userSharedState = userSharedState.copyWith(
      selectedImageList: selectToDeleteList,
    );
    notifyListeners();
  }

  void cancelImageList() {
    _userSharedState = userSharedState.copyWith(
      selectedImageList: [],
    );
    notifyListeners();
  }
}
