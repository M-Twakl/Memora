import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/features/auth/presentation/views/login_view.dart';
import 'package:memora/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:memora/features/splash/presentation/views/splash_view.dart';

/// Top-level GoRouter instance configuration.
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri.toString()}'),
      ),
    ),
  );
}
