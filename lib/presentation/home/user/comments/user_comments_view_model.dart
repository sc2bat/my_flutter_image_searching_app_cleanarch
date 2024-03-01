import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/comment/user_comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/comment/user_comment_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/get_user_id_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/comments/user_comments_state.dart';

class UserCommentsViewModel extends ChangeNotifier {
  UserCommentsViewModel({
    required GetUserIdUseCase getUserIdUseCase,
    required UserCommentUseCase userCommentUseCase,
  })  : _getUserIdUseCase = getUserIdUseCase,
        _userCommentUseCase = userCommentUseCase;

  final GetUserIdUseCase _getUserIdUseCase;
  final UserCommentUseCase _userCommentUseCase;

  UserCommentsState _userCommentsState = const UserCommentsState();
  UserCommentsState get userCommentsState => _userCommentsState;

  final session = supabase.auth.currentSession;

  Future<void> init() async {
    _userCommentsState = userCommentsState.copyWith(isLoading: true);
    notifyListeners();

    // userId
    await getUserId(session!.user.id);

    // comment
    // await getUserCommentList(userCommentsState.userId);
    await loadMoreComment(
        userCommentsState.userId, userCommentsState.currentItemCount);

    _userCommentsState = userCommentsState.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> getUserId(String userUuid) async {
    final result = await _getUserIdUseCase.getUserInfo(userUuid);
    result.when(
      success: (data) {
        _userCommentsState = userCommentsState.copyWith(userId: data.userId);
      },
      error: (message) => Result.error(message),
    );
  }

  Future<void> getUserCommentList(int userId) async {
    final result = await _userCommentUseCase.fetchAll(userId);
    result.when(
      success: (data) {
        _userCommentsState = userCommentsState.copyWith(commentList: data);
      },
      error: (message) => Result.error(message),
    );
  }

  Future<void> loadMoreComment(int userId, int offsetVal) async {
    _userCommentsState = userCommentsState.copyWith(additionalLoading: true);
    notifyListeners();

    // 추가 로드
    final result = await _userCommentUseCase.fetchPaginated(userId, offsetVal);
    result.when(
      success: (data) {
        List<UserCommentModel> commentList =
            List.from(userCommentsState.commentList)..addAll(data);
        _userCommentsState = userCommentsState.copyWith(
            commentList: commentList, currentItemCount: commentList.length);
      },
      error: (message) => Result.error(message),
    );

    _userCommentsState = userCommentsState.copyWith(additionalLoading: false);
    notifyListeners();
  }
}
