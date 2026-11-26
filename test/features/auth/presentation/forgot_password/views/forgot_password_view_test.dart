import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/features/auth/presentation/forgot_password/views/forgot_password_view.dart';
import 'package:memora/shared/widgets/custom_button.dart';
import 'package:memora/shared/widgets/custom_text_field.dart';

void main() {
  Widget buildTestWidget({VoidCallback? onCodeSent}) {
    return MaterialApp(
      home: ForgotPasswordView(onCodeSent: onCodeSent),
    );
  }

  void setStandardPhoneViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(393 * 3, 852 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox());
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  testWidgets('ForgotPasswordView renders all elements matching Figma Frame 1:1085 anchored to top', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    // Verify Title and Subtitle
    final titleFinder = find.text(AppStrings.forgotPasswordTitle);
    expect(titleFinder, findsOneWidget);
    expect(find.text(AppStrings.forgotPasswordSubtitle), findsOneWidget);

    // Verify anchored to the top of the viewport (not vertically centered)
    final titleTop = tester.getTopLeft(titleFinder).dy;
    expect(titleTop, lessThan(60.0));

    // Verify input field
    expect(find.byType(CustomTextField), findsOneWidget);
    expect(find.text(AppStrings.emailOrMobile), findsOneWidget);
    expect(find.text(AppStrings.emailPlaceholder), findsOneWidget);

    // Verify send code button
    expect(find.widgetWithText(CustomButton, AppStrings.sendCode), findsOneWidget);
  });

  testWidgets('ForgotPasswordView shows validation error when submitting empty input', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    final sendButton = find.widgetWithText(CustomButton, AppStrings.sendCode);
    await tester.tap(sendButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text(AppStrings.enterEmailOrPhone), findsOneWidget);
  });

  testWidgets('ForgotPasswordView shows validation error for invalid email/phone and accepts valid input', (tester) async {
    setStandardPhoneViewport(tester);
    bool codeSent = false;
    await tester.pumpWidget(buildTestWidget(onCodeSent: () => codeSent = true));
    await tester.pump();

    final inputField = find.byType(TextFormField);
    final sendButton = find.widgetWithText(CustomButton, AppStrings.sendCode);

    // Enter invalid email domain
    await tester.enterText(inputField, 'invalid@yahoo.com');
    await tester.tap(sendButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text(AppStrings.invalidGmailDomain), findsOneWidget);

    // Enter non-email arbitrary text
    await tester.enterText(inputField, 'randomtext');
    await tester.tap(sendButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text(AppStrings.invalidEmailOrPhone), findsOneWidget);

    // Enter valid Egyptian phone
    await tester.enterText(inputField, '01012345678');
    await tester.tap(sendButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Error should be cleared
    expect(find.text(AppStrings.invalidEmailOrPhone), findsNothing);

    // Drain simulated network dispatch timer
    await tester.pump(const Duration(milliseconds: 700));
    expect(codeSent, isTrue);
  });
}
