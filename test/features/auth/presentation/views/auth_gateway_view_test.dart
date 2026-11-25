import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/features/auth/presentation/views/auth_gateway_view.dart';
import 'package:memora/features/auth/presentation/views/widgets/welcome_actions_section.dart';
import 'package:memora/features/auth/presentation/views/widgets/welcome_brand_header.dart';
import 'package:memora/shared/widgets/custom_button.dart';

void main() {
  Widget buildTestWidget() {
    final router = GoRouter(
      initialLocation: AppRoutes.authGateway,
      routes: [
        GoRoute(
          path: AppRoutes.authGateway,
          builder: (context, state) => const AuthGatewayView(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const Scaffold(
            body: Text('Login Destination Screen'),
          ),
        ),
        GoRoute(
          path: AppRoutes.register,
          builder: (context, state) => const Scaffold(
            body: Text('Register Destination Screen'),
          ),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
    );
  }

  testWidgets('AuthGatewayView renders logo, tagline, and both action buttons', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // Verify sectional widgets are present
    expect(find.byType(WelcomeBrandHeader), findsOneWidget);
    expect(find.byType(WelcomeActionsSection), findsOneWidget);

    // Verify tagline text
    expect(find.text(AppStrings.authTagline), findsOneWidget);

    // Verify buttons
    expect(find.widgetWithText(CustomButton, AppStrings.logIn), findsOneWidget);
    expect(find.widgetWithText(CustomButton, AppStrings.register), findsOneWidget);
  });

  testWidgets('Tapping log in button navigates to login route', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(CustomButton, AppStrings.logIn));
    await tester.pumpAndSettle();

    expect(find.text('Login Destination Screen'), findsOneWidget);
  });

  testWidgets('Tapping register button navigates to register route', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(CustomButton, AppStrings.register));
    await tester.pumpAndSettle();

    expect(find.text('Register Destination Screen'), findsOneWidget);
  });
}
