import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/profile/random_photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/profile/save_user_picture_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/choose_user_picture_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class ChooseUserPictureViewModel with ChangeNotifier {
  ChooseUserPictureViewModel({
    required RandomPhotoUseCase randomPhotoUseCase,
    required SaveUserPictureUseCase saveUserPictureUseCase,
  })  : _randomRandomPhotoUseCase = randomPhotoUseCase,
        _saveUserPictureUseCase = saveUserPictureUseCase;
  final RandomPhotoUseCase _randomRandomPhotoUseCase;
  final SaveUserPictureUseCase _saveUserPictureUseCase;

  ChooseUserPictureState _chooseUserPictureState =
      const ChooseUserPictureState();
  ChooseUserPictureState get chooseUserPictureState => _chooseUserPictureState;

  Future<void> init(String userUuid) async {
    _chooseUserPictureState = chooseUserPictureState.copyWith(isLoading: true);
    notifyListeners();

    saveUserUuid(userUuid);

    // pixabay api
    await getPhotoListForChoose();

    _chooseUserPictureState = chooseUserPictureState.copyWith(isLoading: false);
    notifyListeners();
  }

  void saveUserUuid(String userUuid) {
    _chooseUserPictureState =
        chooseUserPictureState.copyWith(userUuid: userUuid);
    notifyListeners();
  }

  Future<void> getPhotoListForChoose() async {
    final result = await _randomRandomPhotoUseCase.execute();

    switch (result) {
      case Success<List<PhotoModel>>():
        _chooseUserPictureState =
            chooseUserPictureState.copyWith(photoList: result.data);
      case Error<List<PhotoModel>>():
        logger.info('error');
    }
    notifyListeners();
  }

  Future<void> saveUserPicture() async {
    try {
      await _saveUserPictureUseCase.execute(chooseUserPictureState.userUuid,
          chooseUserPictureState.selectedUserPicture);
    } catch (e) {
      logger.info('updateUserPicture 에러: $e');
    }
  }

  void selectUserPicture(String previewUrl) {
    _chooseUserPictureState =
        chooseUserPictureState.copyWith(selectedUserPicture: previewUrl);
    notifyListeners();
  }
}
