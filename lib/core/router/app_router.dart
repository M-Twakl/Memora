import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/features/auth/presentation/views/auth_done_view.dart';
import 'package:memora/features/auth/presentation/views/auth_gateway_view.dart';
import 'package:memora/features/auth/presentation/views/login_view.dart';
import 'package:memora/features/auth/presentation/views/verify_code_view.dart';
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
        path: AppRoutes.authGateway,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AuthGatewayView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.verifyCode,
        builder: (context, state) => const VerifyCodeView(),
      ),
      GoRoute(
        path: AppRoutes.authDone,
        builder: (context, state) => const AuthDoneView(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Register View')),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri.toString()}'),
      ),
    ),
  );
}
