import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/di/dependency_injection.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/home_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/history/user_history_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/like/user_like_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/setting/user_settting_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/user_account_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/user_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/sign/sign_in_screen.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/sign/sign_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/splash/splash_screen.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
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
      builder: (_, __) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'user',
          builder: (_, __) => const UserScreen(),
          routes: [
            GoRoute(
              path: 'account',
              builder: (_, __) => const UserAccountScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'like',
              builder: (_, __) => const UserLikeScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'history',
              builder: (_, __) => const UserHistoryScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'setting',
              builder: (_, __) => const UserSettingScreen(),
              routes: const [],
            ),
          ],
        ),
        GoRoute(
          path: 'image',
          builder: (_, __) => const SearchScreen(),
          routes: [
            GoRoute(
              path: 'detail',
              builder: (_, __) => const SearchScreen(),
              routes: const [],
            ),
            GoRoute(
              path: 'edit',
              builder: (_, __) => const SearchScreen(),
              routes: const [],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/search',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<SearchViewModel>(),
        child: const SearchScreen(),
      ),
      routes: [
        GoRoute(
          path: 'window',
          builder: (_, __) => const SearchScreen(),
          routes: const [],
        ),
        GoRoute(
          path: 'result',
          builder: (_, __) => const SearchScreen(),
          routes: const [],
        ),
      ],
    ),
  ],
);
