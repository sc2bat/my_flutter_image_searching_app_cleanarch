import 'package:get_it/get_it.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/photo/photo_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/pixabay/pixabay_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/search/search_keyword_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/comment_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/download_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/image_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/like_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/share_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/sign_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/tag_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/user_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/view_history_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/photo/photo_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/pixabay/pixabay_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/search/search_keyword_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/comment_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/download_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/image_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/like_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/share_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/sign_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/tag_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/user_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/view_history_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/comment/comment_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/comment/get_comment_list_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/download/download_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/download/image_download_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/home/popular_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/home/topsearch_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/like/like_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/image_info_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/photo/photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/search/search_like_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/search/search_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/share/share_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/sign/sign_in_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/sign/sign_out_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/comment/user_comment_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/download/user_download_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/get_user_id_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/history/user_history_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/likes/user_likes_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/profile/load_user_data_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/profile/random_photo_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/profile/save_user_picture_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/profile/update_user_info_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/shared/user_shared_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/view/view_history_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/comments/user_comments_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/downloads/user_downloads_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/history/user_history_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/likes/user_likes_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/choose_user_picture_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/user_profile_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/shared/user_shared_view_model.dart';
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
    ..registerSingleton<CommentRepository>(
      CommentRepositoryImpl(),
    )
    ..registerSingleton<DownloadRepository>(
      DownloadRepositoryImpl(),
    )
    ..registerSingleton<ShareRepository>(
      ShareRepositoryImpl(),
    )
    ..registerSingleton<ViewHistoryRepository>(
      ViewHistoryRepositoryImpl(),
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
    ..registerSingleton<SearchLikeUseCase>(
      SearchLikeUseCase(
        likeRepository: getIt<LikeRepository>(),
      ),
    )
    // popular
    ..registerSingleton<PopularUseCase>(
      PopularUseCase(
        likeRepository: getIt<LikeRepository>(),
      ),
    )
    // topsearch
    ..registerSingleton<TopsearchUseCase>(
      TopsearchUseCase(
        tagRepository: getIt<TagRepository>(),
      ),
    )
    // count info
    ..registerSingleton<ImageInfoUseCase>(
      ImageInfoUseCase(
        imageRepository: getIt<ImageRepository>(),
      ),
    )
    // like
    ..registerSingleton<LikeUseCase>(
      LikeUseCase(
        likeRepository: getIt<LikeRepository>(),
      ),
    )
    ..registerSingleton<UserLikesUseCase>(
      UserLikesUseCase(
        likeRepository: getIt<LikeRepository>(),
      ),
    )
    // download
    ..registerSingleton<ImageDownloadUseCase>(
      ImageDownloadUseCase(
        photoRepository: getIt<PhotoRepository>(),
      ),
    )
    ..registerSingleton<DownloadUseCase>(
      DownloadUseCase(
        downloadRepository: getIt<DownloadRepository>(),
      ),
    )
    ..registerSingleton<UserDownloadUseCase>(
      UserDownloadUseCase(
        downloadRepository: getIt<DownloadRepository>(),
      ),
    )
    // comment
    ..registerSingleton<GetCommentListUseCase>(
      GetCommentListUseCase(
        commentRepositoy: getIt<CommentRepository>(),
      ),
    )
    ..registerSingleton<CommentUseCase>(
      CommentUseCase(
        commentRepositoy: getIt<CommentRepository>(),
      ),
    )
    ..registerSingleton<UserCommentUseCase>(
      UserCommentUseCase(
        commentRepositoy: getIt<CommentRepository>(),
      ),
    )

    // share
    ..registerSingleton<ShareUseCase>(
      ShareUseCase(
        shareRepository: getIt<ShareRepository>(),
      ),
    )
    ..registerSingleton<UserSharedUseCase>(
      UserSharedUseCase(
        shareRepository: getIt<ShareRepository>(),
      ),
    )
    // view
    ..registerSingleton<ViewHistoryUseCase>(
      ViewHistoryUseCase(
        viewHistoryRepository: getIt<ViewHistoryRepository>(),
      ),
    )
    // user_history
    ..registerSingleton<UserHistoryUseCase>(
      UserHistoryUseCase(
        viewHistoryRepository: getIt<ViewHistoryRepository>(),
      ),
    )
    ..registerSingleton<SaveUserPictureUseCase>(
      SaveUserPictureUseCase(
        userRepository: getIt<UserRepository>(),
      ),
    )
    ..registerSingleton<RandomPhotoUseCase>(
      RandomPhotoUseCase(
        imageRepository: getIt<ImageRepository>(),
      ),
    )
    ..registerSingleton<LoadUserDataUseCase>(
      LoadUserDataUseCase(
        userRepository: getIt<UserRepository>(),
      ),
    )
    ..registerSingleton<UpdateUserInfoUseCase>(
      UpdateUserInfoUseCase(
        userRepository: getIt<UserRepository>(),
      ),
    );

  // view models
  // home view model
  getIt
    ..registerFactory<HomeViewModel>(
      () => HomeViewModel(
        popularUseCase: getIt<PopularUseCase>(),
        topsearchUseCase: getIt<TopsearchUseCase>(),
      ),
    )
    // sign view model
    ..registerFactory<SignViewModel>(
      () => SignViewModel(
        signInUseCase: getIt<SignInUseCase>(),
      ),
    )
    // search view model
    ..registerFactory<SearchViewModel>(
      () => SearchViewModel(
        photoUseCase: getIt<PhotoUseCase>(),
        searchUseCase: getIt<SearchUseCase>(),
        searchLikeUseCase: getIt<SearchLikeUseCase>(),
        getUserIdUseCase: getIt<GetUserIdUseCase>(),
      ),
    )
    ..registerFactory<DetailViewModel>(
      () => DetailViewModel(
        getUserIdUseCase: getIt<GetUserIdUseCase>(),
        photoUseCase: getIt<PhotoUseCase>(),
        likeUseCase: getIt<LikeUseCase>(),
        popularUseCase: getIt<PopularUseCase>(),
        imageInfoUseCase: getIt<ImageInfoUseCase>(),
        imageDownloadUseCase: getIt<ImageDownloadUseCase>(),
        downloadUseCase: getIt<DownloadUseCase>(),
        getCommentListUseCase: getIt<GetCommentListUseCase>(),
        commentUseCase: getIt<CommentUseCase>(),
        shareUseCase: getIt<ShareUseCase>(),
        viewHistoryUseCase: getIt<ViewHistoryUseCase>(),
      ),
    )
    // user
    ..registerFactory<UserProfileViewModel>(
      () => UserProfileViewModel(
        loadUserDataUseCase: getIt<LoadUserDataUseCase>(),
        updateUserInfoUseCase: getIt<UpdateUserInfoUseCase>(),
      ),
    )
    // comments
    ..registerFactory<UserCommentsViewModel>(
      () => UserCommentsViewModel(
        getUserIdUseCase: getIt<GetUserIdUseCase>(),
        userCommentUseCase: getIt<UserCommentUseCase>(),
      ),
    )
    // history
    ..registerFactory<UserHistoryViewModel>(
      () => UserHistoryViewModel(
        userHistoryUseCase: getIt<UserHistoryUseCase>(),
      ),
    )
    // downloads
    ..registerFactory<UserDownloadsViewModel>(
      () => UserDownloadsViewModel(
        getUserIdUseCase: getIt<GetUserIdUseCase>(),
        userDownloadUseCase: getIt<UserDownloadUseCase>(),
      ),
    )
    // likes
    ..registerFactory<UserLikesViewModel>(
      () => UserLikesViewModel(
        userLikesUseCase: getIt<UserLikesUseCase>(),
      ),
    )
    // shared
    ..registerFactory<UserSharedViewModel>(
      () => UserSharedViewModel(
        userSharedUseCase: getIt<UserSharedUseCase>(),
      ),
    )
    ..registerFactory<ChooseUserPictureViewModel>(
      () => ChooseUserPictureViewModel(
        randomPhotoUseCase: getIt<RandomPhotoUseCase>(),
        saveUserPictureUseCase: getIt<SaveUserPictureUseCase>(),
      ),
    );
}
