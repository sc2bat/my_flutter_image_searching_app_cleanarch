import 'package:get_it/get_it.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/pixabay_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/sign/signout_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/sign/sign_view_model.dart';

final getIt = GetIt.instance;

void registerDependencies() {
  // repositories
  // sign repository
  // photo repository
  getIt.registerSingleton<PixabayRepository>(
    PixabayRepositoryImpl(),
  );

  // use cases
  // sign use case
  getIt.registerSingleton<SignoutUseCase>(
    SignoutUseCase(),
  );
  // photo
  getIt.registerSingleton<PhotoUseCase>(
    PhotoUseCase(
      pixabayRepository: getIt<PixabayRepository>(),
    ),
  );

  // view models
  // home view model
  getIt.registerFactory<HomeViewModel>(
    () => HomeViewModel(),
  );
  // sign view model
  getIt.registerFactory<SignViewModel>(
    () => SignViewModel(
      signoutUseCase: getIt<SignoutUseCase>(),
    ),
  );
  // search view model
  getIt.registerFactory<SearchViewModel>(
    () => SearchViewModel(
      photoUseCase: getIt<PhotoUseCase>(),
    ),
  );
}
