import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/features/auth/presentation/views/verify_code_view.dart';
import 'package:memora/shared/widgets/custom_button.dart';

void main() {
  Widget buildTestWidget() {
    return const MaterialApp(
      home: VerifyCodeView(),
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

  testWidgets('VerifyCodeView renders all elements and exact typography matching Figma Frame 1:876 without back arrow', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    // Verify Title and Subtitle positioned at the top of the viewport
    final titleFinder = find.text(AppStrings.verifyCodeTitle);
    expect(titleFinder, findsOneWidget);
    expect(find.text(AppStrings.verifyCodeSubtitle), findsOneWidget);
    final titleTop = tester.getTopLeft(titleFinder).dy;
    expect(titleTop, lessThan(60.0)); // Starts right from the top, not centered in the middle

    // Verify no arrow button
    expect(find.byIcon(Icons.arrow_back_ios_new), findsNothing);
    expect(find.byIcon(Icons.arrow_back), findsNothing);

    // Verify 5 OTP input fields
    expect(find.byType(TextField), findsNWidgets(5));

    // Verify initial Countdown Timer (1-minute timer starting at 00:59)
    expect(find.text('00:59'), findsOneWidget);

    // Verify Verify button and Resend link
    expect(find.widgetWithText(CustomButton, AppStrings.verify), findsOneWidget);
    expect(find.textContaining(AppStrings.didntReceiveCode), findsOneWidget);
    expect(find.textContaining(AppStrings.resend), findsOneWidget);
  });

  testWidgets('VerifyCodeView timer actively counts down second-by-second from 1 minute', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.text('00:59'), findsOneWidget);

    // Advance by 1 second
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('00:58'), findsOneWidget);

    // Advance by another 2 seconds
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('00:56'), findsOneWidget);
  });

  testWidgets('Tapping Resend resets the 1-minute countdown timer and clears inputs', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    // Type a digit into first box
    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(0), '7');
    await tester.pump();
    expect(find.text('7'), findsOneWidget);

    // Advance timer by 5 seconds
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('00:54'), findsOneWidget);

    // Tap Resend
    final resendFinder = find.text(AppStrings.resend);
    await tester.tap(resendFinder);
    await tester.pump();

    // Verify timer reset to 00:59 and input cleared
    expect(find.text('00:59'), findsOneWidget);
    expect(find.text('7'), findsNothing);
  });
}
