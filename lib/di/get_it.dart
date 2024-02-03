import 'package:get_it/get_it.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/pixabay_api_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repository/pixabay_api_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';

final getIt = GetIt.instance;

void setup() {
  // repository
  getIt.registerSingleton<PixabayApiRepository>(
    PixabayApiRepositoryImpl(),
  );

  // view model
  getIt.registerFactory<SearchViewModel>(
    () => SearchViewModel(
      pixabayApiRepository: getIt<PixabayApiRepository>(),
    ),
  );
}
