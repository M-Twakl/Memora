import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/features/auth/presentation/views/login_view.dart';
import 'package:memora/features/auth/presentation/views/verify_code_view.dart';
import 'package:memora/features/auth/presentation/views/widgets/invalid_credentials_notice.dart';
import 'package:memora/features/auth/presentation/views/widgets/login_footer_section.dart';
import 'package:memora/features/auth/presentation/views/widgets/login_form_section.dart';
import 'package:memora/features/auth/presentation/views/widgets/login_header_section.dart';
import 'package:memora/features/auth/presentation/views/widgets/or_divider_section.dart';
import 'package:memora/features/auth/presentation/views/widgets/social_auth_section.dart';
import 'package:memora/shared/widgets/custom_button.dart';
import 'package:memora/shared/widgets/custom_text_field.dart';
import 'package:memora/shared/widgets/marquee_error_text.dart';

void main() {
  Widget buildTestWidget() {
    final testRouter = GoRouter(
      initialLocation: AppRoutes.login,
      routes: [
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: AppRoutes.verifyCode,
          builder: (context, state) => const VerifyCodeView(),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: testRouter,
    );
  }

  void setStandardPhoneViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(393 * 3, 900 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  testWidgets('LoginView renders all five sections properly', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // Verify sections
    expect(find.byType(LoginHeaderSection), findsOneWidget);
    expect(find.byType(LoginFormSection), findsOneWidget);
    expect(find.byType(OrDividerSection), findsOneWidget);
    expect(find.byType(SocialAuthSection), findsOneWidget);
    expect(find.byType(LoginFooterSection), findsOneWidget);

    // Verify key text elements
    expect(find.text(AppStrings.welcomeBack), findsOneWidget);
    expect(find.text(AppStrings.signInSubtitle), findsOneWidget);
    expect(find.text(AppStrings.nationalId), findsOneWidget);
    expect(find.text(AppStrings.emailOrMobile), findsOneWidget);
    expect(find.text(AppStrings.password), findsOneWidget);
    expect(find.text(AppStrings.forgotPassword), findsOneWidget);
    expect(find.text(AppStrings.orDivider), findsOneWidget);
    expect(find.text(AppStrings.continueWithApple), findsOneWidget);
    expect(find.text(AppStrings.continueWithFacebook), findsOneWidget);
    expect(find.text(AppStrings.continueWithGoogle), findsOneWidget);
    expect(find.widgetWithText(CustomButton, AppStrings.logIn), findsOneWidget);
    expect(find.textContaining('Don’t have an account?'), findsOneWidget);
    expect(find.textContaining('Register'), findsOneWidget);
  });

  testWidgets('Tapping log in with empty fields shows validation errors using MarqueeErrorText', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    final loginButtonFinder = find.widgetWithText(CustomButton, AppStrings.logIn);
    await tester.ensureVisible(loginButtonFinder);
    await tester.tap(loginButtonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Validation error messages
    expect(find.text(AppStrings.enterNationalId), findsOneWidget);
    expect(find.text(AppStrings.enterEmailOrPhone), findsOneWidget);
    expect(find.text(AppStrings.enterPassword), findsOneWidget);

    // Verifies dynamic MarqueeErrorText widget wraps error messages
    expect(find.byType(MarqueeErrorText), findsNWidgets(3));
  });

  testWidgets('Submitting invalid field formats displays specific validation messages', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    final textFormFields = find.byType(TextFormField);
    // Invalid national id: 10 digits
    await tester.enterText(textFormFields.at(0), '1234567890');
    // Invalid email: non-gmail
    await tester.enterText(textFormFields.at(1), 'user@yahoo.com');
    // Invalid password: only lowercase, no special char/numbers
    await tester.enterText(textFormFields.at(2), 'short');
    await tester.pumpAndSettle();

    final loginButtonFinder = find.widgetWithText(CustomButton, AppStrings.logIn);
    await tester.ensureVisible(loginButtonFinder);
    await tester.tap(loginButtonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text(AppStrings.invalidNationalId), findsOneWidget);
    expect(find.text(AppStrings.invalidGmailDomain), findsOneWidget);
    expect(find.text(AppStrings.passwordLength), findsOneWidget);
  });

  testWidgets('Password visibility toggles when tapping eye icon', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    final passwordFieldFinder = find.widgetWithText(CustomTextField, AppStrings.password);
    expect(passwordFieldFinder, findsOneWidget);

    // Initial state is obscured
    final initialTextField = tester.widget<TextField>(
      find.descendant(of: passwordFieldFinder, matching: find.byType(TextField)),
    );
    expect(initialTextField.obscureText, isTrue);

    // Find and tap the suffix eye icon
    final eyeIconFinder = find.descendant(
      of: passwordFieldFinder,
      matching: find.byType(GestureDetector),
    );
    await tester.tap(eyeIconFinder);
    await tester.pumpAndSettle();

    // Verify visibility toggled
    final toggledTextField = tester.widget<TextField>(
      find.descendant(of: passwordFieldFinder, matching: find.byType(TextField)),
    );
    expect(toggledTextField.obscureText, isFalse);
  });

  testWidgets('Submitting state shows guidance text and loading indicator, then navigates to verify code on success', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // Enter valid credentials
    final textFormFields = find.byType(TextFormField);
    await tester.enterText(textFormFields.at(0), '29901011234567');
    await tester.enterText(textFormFields.at(1), 'patient@gmail.com');
    await tester.enterText(textFormFields.at(2), 'Secret123!');
    await tester.pumpAndSettle();

    // Tap submit button
    final loginButtonFinder = find.widgetWithText(CustomButton, AppStrings.logIn);
    await tester.ensureVisible(loginButtonFinder);
    await tester.tap(loginButtonFinder);
    await tester.pump(const Duration(milliseconds: 100));

    // 1. Verify Submitting state (Figma Frame 1:908)
    expect(find.text(AppStrings.signingInGuidance), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // 2. Let authentication complete and verify navigation to Verify Code screen (Figma Frame 1:876)
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.byType(VerifyCodeView), findsOneWidget);
    expect(find.text(AppStrings.verifyCodeTitle), findsOneWidget);
  });

  testWidgets('Submitting invalid credentials displays state notice and Try Again button', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // Enter credentials configured to fail
    final textFormFields = find.byType(TextFormField);
    await tester.enterText(textFormFields.at(0), '29901011234567');
    await tester.enterText(textFormFields.at(1), 'fail@gmail.com');
    await tester.enterText(textFormFields.at(2), 'Wrong123!');
    await tester.pumpAndSettle();

    // Tap submit button
    final loginButtonFinder = find.widgetWithText(CustomButton, AppStrings.logIn);
    await tester.ensureVisible(loginButtonFinder);
    await tester.tap(loginButtonFinder);
    await tester.pump(const Duration(milliseconds: 100));

    // Verify submitting state first
    expect(find.text(AppStrings.signingInGuidance), findsOneWidget);

    // Let the failed authentication complete
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle();

    // Verify Invalid credentials state notice (Figma Frame 1:954)
    expect(find.byType(InvalidCredentialsNotice), findsOneWidget);
    expect(find.text(AppStrings.invalidCredentialsNotice), findsOneWidget);
    expect(find.widgetWithText(CustomButton, AppStrings.tryAgain), findsOneWidget);

    // Editing an input field dismisses the notice
    await tester.enterText(textFormFields.at(1), 'user@gmail.com');
    await tester.pumpAndSettle();

    expect(find.byType(InvalidCredentialsNotice), findsNothing);
    expect(find.widgetWithText(CustomButton, AppStrings.logIn), findsOneWidget);
  });
}
