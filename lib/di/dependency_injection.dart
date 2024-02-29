import 'package:get_it/get_it.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/comment/comment_repositoy_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/photo/photo_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/pixabay/pixabay_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/search/search_keyword_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/image_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/like_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/sign_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/tag_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/user/user_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/comment/comment_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/photo/photo_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay/pixabay_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/search/search_keyword_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/image_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/like_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/sign_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/tag_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/user/user_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/comment/comment_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/comment/get_comment_list_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/download/image_download_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/home/popular_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/home/topsearch_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/like/like_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/search/search_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/sign/sign_in_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/sign/sign_out_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/get_user_id_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/sign/sign_view_model.dart';

final getIt = GetIt.instance;

void registerDependencies() {
  // repositories
  // sign repository
  // photo repository
  getIt
    ..registerSingleton<SignRepository>(
      SignRepositoryImpl(),
    )
    ..registerSingleton<UserRepository>(
      UserRepositoryImpl(),
    )
    ..registerSingleton<PixabayRepository>(
      PixabayRepositoryImpl(),
    )
    ..registerSingleton<SearchKeywordRepository>(
      SearchKeywordRepositoryImpl(),
    )
    ..registerSingleton<ImageRepository>(
      ImageRepositoryImpl(),
    )
    ..registerSingleton<LikeRepository>(
      LikeRepositoryImpl(),
    )
    ..registerSingleton<TagRepository>(
      TagRepositoryImpl(),
    )
    ..registerSingleton<PhotoRepository>(
      PhotoRepositoryImpl(),
    )
    ..registerSingleton<CommentRepositoy>(
      CommentRepositoyImpl(),
    );

  // use cases
  getIt
    // sign use case
    ..registerSingleton<SignInUseCase>(
      SignInUseCase(
        signRepository: getIt<SignRepository>(),
      ),
    )
    ..registerSingleton<SignOutUseCase>(
      SignOutUseCase(
        signRepository: getIt<SignRepository>(),
      ),
    )
    ..registerSingleton<GetUserIdUseCase>(
      GetUserIdUseCase(
        userRepository: getIt<UserRepository>(),
      ),
    )
    // photo
    ..registerSingleton<PhotoUseCase>(
      PhotoUseCase(
        pixabayRepository: getIt<PixabayRepository>(),
        imageRepository: getIt<ImageRepository>(),
      ),
    )
    // search
    ..registerSingleton<SearchUseCase>(
      SearchUseCase(
        searchKeywordRepository: getIt<SearchKeywordRepository>(),
      ),
    )
    // popular
    ..registerSingleton<PopularUserCase>(
      PopularUserCase(
        likeRepository: getIt<LikeRepository>(),
      ),
    )
    // topsearch
    ..registerSingleton<TopsearchUseCase>(
      TopsearchUseCase(
        tagRepository: getIt<TagRepository>(),
      ),
    )
    // like
    ..registerSingleton<LikeUseCase>(
      LikeUseCase(
        likeRepository: getIt<LikeRepository>(),
      ),
    )
    // download
    ..registerSingleton<ImageDownloadUseCase>(
      ImageDownloadUseCase(
        photoRepository: getIt<PhotoRepository>(),
      ),
    )
    // comment
    ..registerSingleton<GetCommentListUseCase>(
      GetCommentListUseCase(
        commentRepositoy: getIt<CommentRepositoy>(),
      ),
    )
    ..registerSingleton<CommentUseCase>(
      CommentUseCase(
        commentRepositoy: getIt<CommentRepositoy>(),
      ),
    );

  // view models
  // home view model
  getIt
    ..registerFactory<HomeViewModel>(
      () => HomeViewModel(
        popularUserCase: getIt<PopularUserCase>(),
        topsearchUseCase: getIt<TopsearchUseCase>(),
        signInUseCase: getIt<SignInUseCase>(),
        signOutUseCase: getIt<SignOutUseCase>(),
      ),
    )
    // sign view model
    ..registerFactory<SignViewModel>(
      () => SignViewModel(
        signInUseCase: getIt<SignInUseCase>(),
        signOutUseCase: getIt<SignOutUseCase>(),
      ),
    )
    // search view model
    ..registerFactory<SearchViewModel>(
      () => SearchViewModel(
        signInUseCase: getIt<SignInUseCase>(),
        signOutUseCase: getIt<SignOutUseCase>(),
        photoUseCase: getIt<PhotoUseCase>(),
        searchUseCase: getIt<SearchUseCase>(),
      ),
    )
    ..registerFactory<DetailViewModel>(
      () => DetailViewModel(
        getUserIdUseCase: getIt<GetUserIdUseCase>(),
        photoUseCase: getIt<PhotoUseCase>(),
        likeUseCase: getIt<LikeUseCase>(),
        popularUserCase: getIt<PopularUserCase>(),
        imageDownloadUseCase: getIt<ImageDownloadUseCase>(),
        getCommentListUseCase: getIt<GetCommentListUseCase>(),
        commentUseCase: getIt<CommentUseCase>(),
      ),
    );
}
