import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class DetailViewModel with ChangeNotifier {
  final PhotoUseCase _photoUseCase;

  DetailViewModel({
    required PhotoUseCase photoUseCase,
  }) : _photoUseCase = photoUseCase;

  // state
  DetailState _detailState = const DetailState();
  DetailState get detailState => _detailState;

  Future<void> init(int imageId) async {
    _detailState = detailState.copyWith(isLoading: true);
    notifyListeners();

    late PhotoModel photoData;

    final photoResult = await _photoUseCase.fetchOne(imageId);
    photoResult.when(
      success: (data) {
        logger.info(data);
        photoData = data;
      },
      error: (message) => logger.info(message),
    );
    _detailState = detailState.copyWith(isLoading: false, photo: photoData);
    notifyListeners();
  }
  // search use case

  // comment use case

  // download use case

  // share use case

  // like use case
}
