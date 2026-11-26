import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/features/auth/presentation/views/new_password_view.dart';
import 'package:memora/shared/widgets/custom_button.dart';
import 'package:memora/shared/widgets/custom_text_field.dart';

void main() {
  Widget buildTestWidget({VoidCallback? onPasswordCreated}) {
    return MaterialApp(
      home: NewPasswordView(onPasswordCreated: onPasswordCreated),
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

  testWidgets('NewPasswordView renders all elements matching Figma Frame 1:1006 anchored to top', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // Verify Title and Subtitle
    final titleFinder = find.text(AppStrings.createPasswordTitle);
    expect(titleFinder, findsOneWidget);
    expect(find.text(AppStrings.createPasswordSubtitle), findsOneWidget);

    // Verify anchored to top of viewport
    final titleTop = tester.getTopLeft(titleFinder).dy;
    expect(titleTop, lessThan(60.0));

    // Verify both Password and Confirm Password fields
    expect(find.byType(CustomTextField), findsNWidgets(2));
    expect(find.text(AppStrings.password), findsOneWidget);
    expect(find.text(AppStrings.confirmPassword), findsOneWidget);

    // Verify create new password button
    expect(find.widgetWithText(CustomButton, AppStrings.createNewPassword), findsOneWidget);
  });

  testWidgets('NewPasswordView shows validation errors matching Figma Frame 1:1157', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    final textFields = find.byType(TextFormField);
    final passwordField = textFields.at(0);
    final confirmPasswordField = textFields.at(1);
    final submitButton = find.widgetWithText(CustomButton, AppStrings.createNewPassword);

    // Enter 4 characters in Password (Figma Frame 1:1157 Node 1:1168 "••••")
    await tester.enterText(passwordField, 'Pass');
    // Enter mismatching 5 characters in Confirm Password (Figma Frame 1:1157 Node 1:1177 "•••••")
    await tester.enterText(confirmPasswordField, 'Passw');
    await tester.tap(submitButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Verify exact Figma error messages
    expect(find.text('Use at least 6 characters. You’ve entered 4.'), findsOneWidget);
    expect(find.text(AppStrings.passwordsDoNotMatch), findsOneWidget);
  });

  testWidgets('NewPasswordView toggles password visibility when eye icon tapped', (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    final eyeIcons = find.byIcon(Icons.visibility_outlined);
    expect(eyeIcons, findsNWidgets(2));

    // Tap first eye icon
    await tester.tap(eyeIcons.first);
    await tester.pump();

    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
  });

  testWidgets('NewPasswordView submits valid matching passwords and triggers callback', (tester) async {
    setStandardPhoneViewport(tester);
    bool created = false;
    await tester.pumpWidget(buildTestWidget(onPasswordCreated: () => created = true));
    await tester.pump();

    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'Secret123!');
    await tester.enterText(textFields.at(1), 'Secret123!');
    await tester.pump();

    final submitButton = find.widgetWithText(CustomButton, AppStrings.createNewPassword);
    await tester.tap(submitButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    expect(created, isTrue);
  });
}
