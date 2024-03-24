// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';
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

  Future<void> loadUserInfo(String userUuid) async {
    final result = await _loadUserDataUseCase.execute(userUuid);
    result.when(
      success: (data) {
        _userProfileState = userProfileState.copyWith(userModel: data);
        notifyListeners();
      },
      error: (error) => throw Exception(error),
    );
  }

  Future<void> updateUserInfo() async {
    if (userProfileState.userModel != null) {
      await _updateUserInfoUseCase.execute(userProfileState.userModel!);
      showSnackBar('Changes saved successfully');
    }
  }

  void showSnackBar(String message) {
    _userProfileUiEventStreamController
        .add(UserProfileUiEvent.showSnackBar(message));
  }

  Future<void> deleteUser() async {
    await _deleteUserUseCase.execute();
  }

  void modifyPicture(String userPicture) {
    if (userProfileState.userModel != null) {
      UserModel userModel = userProfileState.userModel!;
      userModel.userPicture = userPicture;
      _userProfileState = userProfileState.copyWith(userModel: userModel);
      notifyListeners();
    } else {
      showSnackBar('updatePicture error');
    }
  }

  void modifyUserName(String userName) {
    if (userProfileState.userModel != null) {
      UserModel userModel = userProfileState.userModel!;
      userModel.userName = userName;
      _userProfileState = userProfileState.copyWith(userModel: userModel);
      notifyListeners();
    } else {
      showSnackBar('modifyUserName error');
    }
  }

  void modifyUserBio(String userBio) {
    if (userProfileState.userModel != null) {
      UserModel userModel = userProfileState.userModel!;
      userModel.userBio = userBio;
      _userProfileState = userProfileState.copyWith(userModel: userModel);
      notifyListeners();
    } else {
      showSnackBar('modifyUserBio error');
    }
  }
}
