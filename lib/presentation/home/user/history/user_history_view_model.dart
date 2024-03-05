import 'dart:async';

import 'package:flutter/cupertino.dart';
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

  UserHistoryState _userHistoryState = UserHistoryState();

  UserHistoryState get userHistoryState => _userHistoryState;
  List<bool> getSelectedImageList() {
    return List.generate(userHistoryState.userHistoryList.length, (_) => false);
  }

  Future<void> init(int userId) async {
    _userHistoryState = userHistoryState.copyWith(isLoading: true);
    notifyListeners();

    final userHistoryResult =
        await _userHistoryUseCase.getUserHistoryList(userId);
    userHistoryResult.when(
        success: (data) {
          _userHistoryState = userHistoryState.copyWith(
              userHistoryList: data,
          selectedImageList: getSelectedImageList(),);
        },
        error: (message) {
          logger.info('userHistoryResult 가져오는 error $message');
        },
    );
    logger.info('${userHistoryState.userHistoryList}');
    _userHistoryState = userHistoryState.copyWith(isLoading: false);
    notifyListeners();
  }
}
