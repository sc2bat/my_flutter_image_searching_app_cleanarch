import 'package:get_it/get_it.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/pixabay_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';

final getIt = GetIt.instance;

void registerDependencies() {
  // repository
  getIt.registerSingleton<PixabayRepository>(
    PixabayRepositoryImpl(),
  );

  // view model
  getIt.registerFactory<SearchViewModel>(
    () => SearchViewModel(
      pixabayApiRepository: getIt<PixabayRepository>(),
    ),
  );
}
