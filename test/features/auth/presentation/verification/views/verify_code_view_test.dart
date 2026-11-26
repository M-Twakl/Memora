import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/features/auth/presentation/verification/views/verify_code_view.dart';
import 'package:memora/shared/widgets/custom_button.dart';

void main() {
  Widget buildTestWidget({
    VerifyCodeStatus initialStatus = VerifyCodeStatus.normal,
    VoidCallback? onVerified,
  }) {
    return MaterialApp(
      home: VerifyCodeView(
        initialStatus: initialStatus,
        onVerified: onVerified,
      ),
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

  testWidgets('VerifyCodeView renders normal state matching Figma Frame 1:876 / 1:1064', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    // Verify Title and Subtitle positioned at the top of the viewport
    final titleFinder = find.text(AppStrings.verifyCodeTitle);
    expect(titleFinder, findsOneWidget);
    expect(find.text(AppStrings.verifyCodeSubtitle), findsOneWidget);
    final titleTop = tester.getTopLeft(titleFinder).dy;
    expect(titleTop, lessThan(60.0));

    // Verify no arrow button
    expect(find.byIcon(Icons.arrow_back_ios_new), findsNothing);

    // Verify 5 OTP input fields
    expect(find.byType(TextField), findsNWidgets(5));

    // Verify initial Countdown Timer (00:59)
    expect(find.text('00:59'), findsOneWidget);

    // Verify Verify button and Resend link
    expect(find.widgetWithText(CustomButton, AppStrings.verify), findsOneWidget);
    expect(find.textContaining(AppStrings.didntReceiveCode), findsOneWidget);
    expect(find.text(AppStrings.resend), findsOneWidget);
  });

  testWidgets('VerifyCodeView renders Incorrect Code state matching Figma Frame 1:1099', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget(initialStatus: VerifyCodeStatus.incorrect));
    await tester.pump();

    // Verify prefilled digits (4 8 2 1 6)
    expect(find.text('4'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);

    // Verify error message & guidance
    expect(find.text(AppStrings.codeDoesNotMatch), findsOneWidget);
    expect(find.text(AppStrings.codeExpiresGuidance), findsOneWidget);

    // Verify action button changes to "Try Again"
    expect(find.widgetWithText(CustomButton, AppStrings.tryAgain), findsOneWidget);

    // Tapping Try Again resets the state to normal
    final tryAgainBtn = find.widgetWithText(CustomButton, AppStrings.tryAgain);
    await tester.tap(tryAgainBtn);
    await tester.pump();

    expect(find.text(AppStrings.codeDoesNotMatch), findsNothing);
    expect(find.widgetWithText(CustomButton, AppStrings.verify), findsOneWidget);
  });

  testWidgets('VerifyCodeView renders Expired state matching Figma Frame 1:1037', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget(initialStatus: VerifyCodeStatus.expired));
    await tester.pump();

    // Verify expired error message & guidance
    expect(find.text(AppStrings.codeExpiredMessage), findsOneWidget);
    expect(find.text(AppStrings.codeExpiredGuidance), findsOneWidget);

    // Verify timer is at 00:00
    expect(find.text(AppStrings.timerZero), findsOneWidget);

    // Verify button is disabled "Verify"
    final verifyButton = find.widgetWithText(CustomButton, AppStrings.verify);
    expect(verifyButton, findsOneWidget);

    // Verify inputs are disabled
    final firstTextField = tester.widget<TextField>(find.byType(TextField).first);
    expect(firstTextField.enabled, isFalse);

    // Resend link is active
    expect(find.text(AppStrings.resend), findsOneWidget);
  });

  testWidgets('VerifyCodeView renders Resend Cooldown state with 1-minute countdown matching Figma Frame 1:1126', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget(initialStatus: VerifyCodeStatus.resendCooldown));
    await tester.pump();

    // Verify info state notice banner
    expect(find.text(AppStrings.newCodeSentNotice), findsOneWidget);

    // Verify 1-minute countdown
    expect(find.text('00:59'), findsOneWidget);

    // Verify guidance under timer
    expect(find.text(AppStrings.enterNewCodeGuidance), findsOneWidget);

    // Verify disabled resend with 1-minute countdown (59s)
    expect(find.textContaining('${AppStrings.resend} (59s)'), findsOneWidget);
    expect(find.text(AppStrings.resendCooldownGuidance), findsOneWidget);
  });

  testWidgets('Tapping Resend dynamically displays notice and resets 1-minute countdown on the same screen', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    // Tap Resend
    final resendFinder = find.text(AppStrings.resend);
    await tester.tap(resendFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify dynamic state notice banner appears on the same screen
    expect(find.text(AppStrings.newCodeSentNotice), findsOneWidget);
    // Verify 1-minute countdown reset
    expect(find.text('00:59'), findsOneWidget);
    // Verify cooldown text
    expect(find.textContaining('${AppStrings.resend} (59s)'), findsOneWidget);
    expect(find.text(AppStrings.resendCooldownGuidance), findsOneWidget);
  });

  testWidgets('Submitting incorrect code triggers Incorrect Code state', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(0), '4');
    await tester.enterText(textFields.at(1), '8');
    await tester.enterText(textFields.at(2), '2');
    await tester.enterText(textFields.at(3), '1');
    await tester.enterText(textFields.at(4), '6');
    await tester.pump();

    final verifyButton = find.widgetWithText(CustomButton, AppStrings.verify);
    await tester.tap(verifyButton);
    await tester.pump();

    expect(find.text(AppStrings.codeDoesNotMatch), findsOneWidget);
    expect(find.widgetWithText(CustomButton, AppStrings.tryAgain), findsOneWidget);
  });

  testWidgets('Submitting valid code triggers onVerified callback', (tester) async {
    setStandardPhoneViewport(tester);
    bool verified = false;
    await tester.pumpWidget(buildTestWidget(onVerified: () => verified = true));
    await tester.pump();

    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(0), '1');
    await tester.enterText(textFields.at(1), '1');
    await tester.enterText(textFields.at(2), '1');
    await tester.enterText(textFields.at(3), '1');
    await tester.enterText(textFields.at(4), '1');
    await tester.pump();

    final verifyButton = find.widgetWithText(CustomButton, AppStrings.verify);
    await tester.tap(verifyButton);
    await tester.pump();

    expect(verified, isTrue);
  });
}
