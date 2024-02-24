import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/di/dependency_injection.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/comment/user_account_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/download/user_download_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/like/user_like_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/user_profile_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/share/user_share_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/user_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/view/user_view_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/sign/sign_in_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/sign/sign_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/splash/splash_screen.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: '/index',
  routes: [
    GoRoute(
      path: '/index',
      builder: (_, __) => const SplashScreen(),
      routes: const [],
    ),
    GoRoute(
      path: '/signIn',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<SignViewModel>(),
        child: const SignInScreen(),
      ),
      routes: const [],
    ),
    GoRoute(
      path: '/home',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<HomeViewModel>(),
        child: const HomeScreen(),
      ),
      routes: [
        GoRoute(
          path: 'user',
          builder: (_, __) => const UserScreen(),
          routes: [
            GoRoute(
              path: 'comment',
              builder: (_, __) => const UserCommentScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'download',
              builder: (_, __) => const UserDownloadScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'profile',
              builder: (_, __) => const UserProfileScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'like',
              builder: (_, __) => const UserLikeScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'share',
              builder: (_, __) => const UserShareScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'view',
              builder: (_, __) => const UserViewScreen(),
              routes: const [],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/search',
      builder: (_, state) {
        final map = state.extra! as Map<String, dynamic>;
        return ChangeNotifierProvider(
          create: (_) => getIt<SearchViewModel>(),
          child: SearchScreen(
            searchKeyword: map['searchKeyword'] as String,
          ),
        );
      },
      routes: const [],
    ),
    GoRoute(
      path: '/detail',
      builder: (_, state) {
        final map = state.extra! as Map<String, dynamic>;
        return ChangeNotifierProvider(
          create: (_) => getIt<DetailViewModel>(),
          child: DetailScreen(
            imageId: map['imageId'],
          ),
        );
      },
      routes: const [],
    ),
  ],
);
