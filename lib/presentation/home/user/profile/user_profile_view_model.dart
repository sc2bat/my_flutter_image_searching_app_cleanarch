// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/profile/delete_user_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/profile/load_user_data_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/profile/update_user_info_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/user_profile_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/user_profile_ui_event.dart';

class UserProfileViewModel with ChangeNotifier {
  final LoadUserDataUseCase _loadUserDataUseCase;
  final UpdateUserInfoUseCase _updateUserInfoUseCase;
  final DeleteUserUseCase _deleteUserUseCase;

  UserProfileViewModel({
    required LoadUserDataUseCase loadUserDataUseCase,
    required UpdateUserInfoUseCase updateUserInfoUseCase,
    required DeleteUserUseCase deleteUserUseCase,
  })  : _updateUserInfoUseCase = updateUserInfoUseCase,
        _loadUserDataUseCase = loadUserDataUseCase,
        _deleteUserUseCase = deleteUserUseCase;

  // state
  UserProfileState _userProfileState = UserProfileState();
  UserProfileState get userProfileState => _userProfileState;

  final _userProfileUiEventStreamController =
      StreamController<UserProfileUiEvent>();
  Stream<UserProfileUiEvent> get userProfileUiEventStreamController =>
      _userProfileUiEventStreamController.stream;

  Future<void> init(String userUuid) async {
    // 유저 정보 회회
    await loadUserInfo(userUuid);
  }

  Future<void> loadUserInfo(String userUuid) async {
    final result = await _loadUserDataUseCase.execute(userUuid);
    result.when(
      success: (data) {
        _userProfileState = userProfileState.copyWith(
          userUuid: userUuid,
          userName: data.userName,
          userBio: data.userBio,
          userPicture: data.userPicture,
          isLoading: false,
        );
        notifyListeners();
      },
      error: (error) => throw Exception(error),
    );
  }

  Future<void> updateUserInfo() async {
    await _updateUserInfoUseCase.execute(
      userProfileState.userUuid,
      userProfileState.userName,
      userProfileState.userBio,
      userProfileState.userPicture,
    );
    showSnackBar('Changes saved successfully');
  }

  void showSnackBar(String message) {
    _userProfileUiEventStreamController
        .add(UserProfileUiEvent.showSnackBar(message));
  }

  Future<void> deleteUser() async {
    await _deleteUserUseCase.execute();
  }

  void modifyPicture(String userPicture) {
    _userProfileState = userProfileState.copyWith(userPicture: userPicture);
    notifyListeners();
  }

  void modifyUserName(String userName) {
    _userProfileState = userProfileState.copyWith(userName: userName);
    notifyListeners();
  }

  void modifyUserBio(String userBio) {
    _userProfileState = userProfileState.copyWith(userBio: userBio);
    notifyListeners();
  }
}
