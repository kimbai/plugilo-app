import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugilo/core/common/page/not_found_page.dart';
import 'package:plugilo/core/di/injection.dart';
import 'package:plugilo/core/router/auth_guard.dart';
import 'package:plugilo/presentation/main_bottom_bar/cubit/home_cubit.dart';
import 'package:plugilo/presentation/main_bottom_bar/cubit/home_notification_cubit.dart';
import 'package:plugilo/presentation/main_bottom_bar/main_bottom_bar_page.dart';
import 'package:plugilo/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:plugilo/presentation/onboarding/onboarding_page.dart';
import 'package:plugilo/presentation/sign_in/cubit/sign_in_cubit.dart';
import 'package:plugilo/presentation/sign_in/sign_in_page.dart';
import 'package:plugilo/presentation/splash/cubit/splash_cubit.dart';
import 'package:plugilo/presentation/splash/splash_page.dart';

class AppRoute {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String main = '/';
  static const String signIn = '/signIn';
}

List<RouteBase> get routes {
  return [
    GoRoute(
      path: AppRoute.splash,
      name: AppRoute.splash,
      builder: (context, state) => BlocProvider(
        create: (context) => serviceLocator.get<SplashCubit>(),
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      path: AppRoute.onboarding,
      name: AppRoute.onboarding,
      builder: (context, state) => BlocProvider(
        create: (context) => serviceLocator.get<OnboardingCubit>(),
        child: const OnboardingPage(),
      ),
    ),
    GoRoute(
      path: AppRoute.main,
      name: AppRoute.main,
      builder: (context, state) => AuthGuard(
        fallbackRoute: AppRoute.signIn,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => serviceLocator.get<HomeCubit>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator.get<HomeNotificationCubit>(),
            ),
          ],
          child: const MainBottomBarPage(),
        ),
      ),
    ),
    GoRoute(
      path: AppRoute.signIn,
      name: AppRoute.signIn,
      builder: (context, state) => BlocProvider(
        create: (context) => serviceLocator.get<SignInCubit>(),
        child: const SignInPage(),
      ),
    ),
  ];
}

GoRouter? globalGoRouter;

GoRouter getGoRouter() {
  return globalGoRouter ??= router;
}

void clearAndNavigate(
  String path, {
  Object? extra,
}) {
  while (getGoRouter().canPop() == true) {
    getGoRouter().pop();
  }
  getGoRouter().pushReplacement(path, extra: extra);
}

void popToTop() {
  while (getGoRouter().canPop() == true) {
    getGoRouter().pop();
  }
}

void popToTopAndPush(
  String path, {
  Object? extra,
}) {
  while (getGoRouter().canPop() == true) {
    getGoRouter().pop();
  }
  getGoRouter().push(path, extra: extra);
}

final GoRouter router = GoRouter(
  initialLocation: AppRoute.splash,
  routes: routes,
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: const NotFoundPage(),
  ),
);

CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    // transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
