// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/profile/load_user_data_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/profile/update_user_info_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/user_profile_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/user_profile_ui_event.dart';

class UserProfileViewModel with ChangeNotifier {
  final LoadUserDataUseCase _loadUserDataUseCase;
  final UpdateUserInfoUseCase _updateUserInfoUseCase;

  UserProfileViewModel({
    required LoadUserDataUseCase loadUserDataUseCase,
    required UpdateUserInfoUseCase updateUserInfoUseCase,
  })  : _updateUserInfoUseCase = updateUserInfoUseCase,
        _loadUserDataUseCase = loadUserDataUseCase;

  // state
  final UserProfileState _userProfileState = UserProfileState();
  UserProfileState get userProfileState => _userProfileState;

  final _userProfileUiEventStreamController =
      StreamController<UserProfileUiEvent>();
  Stream<UserProfileUiEvent> get userProfileUiEventStreamController =>
      _userProfileUiEventStreamController.stream;

  Future<UserModel> init(String userUuid) async {
    final result = await _loadUserDataUseCase.execute(userUuid);
    return result.when(
      success: (data) => data,
      error: (error) => throw Exception(error),
    );
  }

  Future<void> updateUserInfo(
      String userUuid, String userName, String userBio) async {
    await _updateUserInfoUseCase.execute(userUuid, userName, userBio);

    showSnackBar('Changes saved successfully');
  }

  void showSnackBar(String message) {
    _userProfileUiEventStreamController
        .add(UserProfileUiEvent.showSnackBar(message));
  }
}
