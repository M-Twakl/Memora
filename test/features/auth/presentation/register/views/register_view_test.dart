import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/features/auth/presentation/register/views/register_view.dart';
import 'package:memora/features/auth/presentation/register/widgets/register_footer_section.dart';
import 'package:memora/features/auth/presentation/register/widgets/register_form_section.dart';
import 'package:memora/features/auth/presentation/register/widgets/register_header_section.dart';
import 'package:memora/features/auth/presentation/shared/widgets/or_divider_section.dart';
import 'package:memora/features/auth/presentation/shared/widgets/social_auth_section.dart';
import 'package:memora/shared/widgets/custom_text_field.dart';

void main() {
  Widget buildTestWidget({VoidCallback? onRegistered}) {
    return MaterialApp(
      home: RegisterView(
        onRegistered: onRegistered,
      ),
    );
  }

  void setStandardPhoneViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(393 * 3, 1100 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  testWidgets('RegisterView renders all sections matching Figma Frame 1:1184',
      (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // 1. Verify Header section
    expect(find.byType(RegisterHeaderSection), findsOneWidget);
    expect(find.text(AppStrings.createYourAccount), findsOneWidget);
    expect(find.text(AppStrings.requiredFieldsNotice), findsNothing);

    // 2. Verify Form section with 5 fields
    expect(find.byType(RegisterFormSection), findsOneWidget);
    expect(find.byType(CustomTextField), findsNWidgets(5));
    expect(find.text(AppStrings.fullName), findsNWidgets(2)); // Label & Hint
    expect(find.text(AppStrings.nationalId), findsOneWidget);
    expect(find.text(AppStrings.emailOrMobile), findsOneWidget);
    expect(find.text(AppStrings.password), findsOneWidget);
    expect(find.text(AppStrings.confirmPassword), findsOneWidget);

    // 3. Verify Or Divider & Social buttons
    expect(find.byType(OrDividerSection), findsOneWidget);
    expect(find.byType(SocialAuthSection), findsOneWidget);

    // 4. Verify Footer section & continue button
    expect(find.byType(RegisterFooterSection), findsOneWidget);
    expect(find.text(AppStrings.continueButton), findsOneWidget);
    expect(find.textContaining(AppStrings.logInLink), findsOneWidget);
  });

  testWidgets(
      'Submitting empty form triggers validation error notice matching Figma Frame 1:1650',
      (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // Tap continue without entering data
    await tester.tap(find.text(AppStrings.continueButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Required fields banner should now be visible
    expect(find.text(AppStrings.requiredFieldsNotice), findsOneWidget);
    expect(find.text(AppStrings.enterFullName), findsOneWidget);
    expect(find.text(AppStrings.enterNationalId), findsOneWidget);
  });

  testWidgets('Submitting valid data triggers onRegistered successfully',
      (tester) async {
    setStandardPhoneViewport(tester);
    bool registeredCalled = false;

    await tester.pumpWidget(
      buildTestWidget(onRegistered: () => registeredCalled = true),
    );
    await tester.pumpAndSettle();

    // Enter Full Name
    await tester.enterText(
      find.widgetWithText(CustomTextField, AppStrings.fullName),
      'Noah Hassan',
    );

    // Enter valid 14-digit National ID
    await tester.enterText(
      find.widgetWithText(CustomTextField, AppStrings.nationalId),
      '29901011234567',
    );

    // Enter valid Gmail address
    await tester.enterText(
      find.widgetWithText(CustomTextField, AppStrings.emailOrMobile),
      'noah.hassan@gmail.com',
    );

    // Enter valid Password (contains uppercase, lowercase, number, special char, >=6 chars)
    await tester.enterText(
      find.widgetWithText(CustomTextField, AppStrings.password),
      'Noah@123',
    );

    // Enter matching Confirm Password
    await tester.enterText(
      find.widgetWithText(CustomTextField, AppStrings.confirmPassword),
      'Noah@123',
    );

    await tester.pumpAndSettle();

    // Tap continue
    await tester.tap(find.text(AppStrings.continueButton));
    await tester.pump(const Duration(milliseconds: 100)); // Start loading
    await tester.pump(const Duration(milliseconds: 900)); // Drain timer

    expect(registeredCalled, isTrue);
  });
}
