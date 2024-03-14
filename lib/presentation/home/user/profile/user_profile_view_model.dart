// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/get_user_id_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class UserProfileViewModel with ChangeNotifier {
  final GetUserIdUseCase _getUserIdUseCase;

  UserProfileViewModel({
    required GetUserIdUseCase getUserIdUseCase,
  }) : _getUserIdUseCase = getUserIdUseCase;

  // state
  // UserProfileState _userProfileState = UserProfileState();
  // UserProfileState get userProfileState => _userProfileState;

  // ui event

  // user use case
  Future<void> getUserId(String userUuid) async {
    final result = await _getUserIdUseCase.getUserInfo(userUuid);

    result.when(
      success: (data) {
        /*
        _userProfileState = userProfileState.copyWith(
          userId: data.userId,
          userName: data.userName,
          userBio: data.userBio,
          userPicture: data.userPicture,
        );*/
      },
      error: (message) {
        logger.info(message);
        throw Exception(message);
      },
    );
  }

  void updateUserPicture(String userPicture) {}
}
