import 'package:get_it/get_it.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/pixabay_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home_view_model.dart';

final getIt = GetIt.instance;

void registerDependencies() {
  // repositories
  getIt.registerSingleton<PixabayRepository>(
    PixabayRepositoryImpl(),
  );

  // use cases
  getIt.registerSingleton<PhotoUseCase>(
    PhotoUseCase(
      pixabayRepository: getIt<PixabayRepository>(),
    ),
  );

  // view models
  getIt.registerFactory<HomeViewModel>(
    () => HomeViewModel(),
  );
  getIt.registerFactory<SearchViewModel>(
    () => SearchViewModel(
      photoUseCase: getIt<PhotoUseCase>(),
    ),
  );
}
