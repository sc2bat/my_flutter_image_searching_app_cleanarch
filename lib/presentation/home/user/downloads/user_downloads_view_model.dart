import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/download/user_download_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/download/user_download_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/get_user_id_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/downloads/user_downloads_state.dart';

class UserDownloadsViewModel extends ChangeNotifier {
  UserDownloadsViewModel({
    required GetUserIdUseCase getUserIdUseCase,
    required UserDownloadUseCase userDownloadUseCase,
  })  : _getUserIdUseCase = getUserIdUseCase,
        _userDownloadUseCase = userDownloadUseCase;

  final GetUserIdUseCase _getUserIdUseCase;
  final UserDownloadUseCase _userDownloadUseCase;

  UserDownloadsState _userDownloadsState = const UserDownloadsState();
  UserDownloadsState get userDownloadsState => _userDownloadsState;

  final session = supabase.auth.currentSession;

  Future<void> init() async {
    _userDownloadsState = userDownloadsState.copyWith(isLoading: true);
    notifyListeners();

    // userId
    await getUserId(session!.user.id);

    // download
    await getUserDownloadList(
        userDownloadsState.userId, userDownloadsState.currentItemCount);

    _userDownloadsState = userDownloadsState.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> getUserId(String userUuid) async {
    final result = await _getUserIdUseCase.getUserInfo(userUuid);
    result.when(
      success: (data) {
        _userDownloadsState = userDownloadsState.copyWith(userId: data.userId);
      },
      error: (message) => Result.error(message),
    );
  }

  Future<void> getUserDownloadList(int userId, int offsetVal) async {
    _userDownloadsState = userDownloadsState.copyWith(additionalLoading: true);
    notifyListeners();

    final result = await _userDownloadUseCase.fetchPaginated(userId, offsetVal);
    result.when(
      success: (data) {
        List<UserDownloadModel> downloadList =
            List.from(userDownloadsState.downloadList)..addAll(data);
        _userDownloadsState = userDownloadsState.copyWith(
            downloadList: downloadList, currentItemCount: downloadList.length);
      },
      error: (message) => Result.error(message),
    );

    _userDownloadsState = userDownloadsState.copyWith(additionalLoading: false);
    notifyListeners();
  }

  Future<void> dismiss(
      {required List<int> indexList, required List<int> downloadIdList}) async {
    final result =
        await _userDownloadUseCase.deleteDownloadHistory(downloadIdList);
    result.when(
      success: (data) {
        List<UserDownloadModel> downloadList =
            List.from(userDownloadsState.downloadList);
        for (int i = 0; i < indexList.length; i++) {
          downloadList.removeAt(indexList[i]);
        }
        _userDownloadsState = userDownloadsState.copyWith(
            downloadList: downloadList, currentItemCount: downloadList.length);
      },
      error: (message) => Result.error(message),
    );

    notifyListeners();
  }
}
