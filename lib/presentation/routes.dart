import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/di/dependency_injection.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/comments/user_comments_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/downloads/user_downloads_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/history/user_history_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/likes/user_likes_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/user_profile_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/shared/user_shared_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/user_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/history/user_history_screen.dart';
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
              path: 'profile',
              builder: (_, __) => const UserProfileScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'history',
              builder: (_, state) {
                final map = state.extra! as Map<String, dynamic>;
                return ChangeNotifierProvider(
                  create: (_) => getIt<UserHistoryViewModel>(),
                  child: UserHistoryScreen(
                    userId: map['userId'],
                  ),
                );
              },
              routes: const [],
            ),
            GoRoute(
              path: 'likes',
              builder: (_, __) => const UserLikesScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'comments',
              builder: (_, __) => const UserCommentsScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'downloads',
              builder: (_, __) => const UserDownloadsScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'shared',
              builder: (_, __) => const UserSharedScreen(),
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
