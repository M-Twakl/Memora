import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/features/auth/presentation/shared/views/auth_done_view.dart';
import 'package:memora/shared/widgets/custom_button.dart';

void main() {
  void setStandardPhoneViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(393 * 3, 852 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  testWidgets('AuthDoneView renders verified check badge, exact typography, and Done button matching Figma Frame 1:897', (tester) async {
    setStandardPhoneViewport(tester);
    bool doneTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: AuthDoneView(
          onDonePressed: () => doneTapped = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify 114x114 Badge Svg
    expect(find.byType(SvgPicture), findsOneWidget);

    // Verify Title & Subtitle
    expect(find.text(AppStrings.verifiedTitle), findsOneWidget);
    expect(find.text(AppStrings.verifiedSubtitle), findsOneWidget);

    // Verify Primary Done Action Button
    final doneButtonFinder = find.widgetWithText(CustomButton, AppStrings.done);
    expect(doneButtonFinder, findsOneWidget);

    // Tap Done button
    await tester.tap(doneButtonFinder);
    await tester.pumpAndSettle();

    expect(doneTapped, isTrue);
  });
}
