import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/di/dependency_injection.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';

void main() {
  test('Dependency Registration Test', () {
    registerDependencies();

    final pixabayRepository = getIt<PixabayRepository>();
    final photoUseCase = getIt<PhotoUseCase>();
    final homeViewModel = getIt<HomeViewModel>();
    final searchViewModel = getIt<SearchViewModel>();

    expect(pixabayRepository, isNotNull);
    expect(photoUseCase, isNotNull);
    expect(homeViewModel, isNotNull);
    expect(searchViewModel, isNotNull);
  });
}
