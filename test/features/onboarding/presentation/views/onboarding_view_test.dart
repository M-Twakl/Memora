import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:memora/features/onboarding/presentation/views/widgets/onboarding_bottom_section.dart';
import 'package:memora/features/onboarding/presentation/views/widgets/onboarding_top_bar.dart';
import 'package:memora/shared/widgets/custom_button.dart';
import 'package:memora/shared/widgets/page_indicator_dots.dart';

void main() {
  Widget buildTestWidget() {
    return const MaterialApp(
      home: OnboardingView(),
    );
  }

  testWidgets('OnboardingView renders initial step correctly', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pump(const Duration(milliseconds: 100));

    // Expect widgets
    expect(find.byType(OnboardingTopBar), findsOneWidget);
    expect(find.byType(PageIndicatorDots), findsOneWidget);
    expect(find.byType(OnboardingBottomSection), findsOneWidget);

    // Initial step content
    expect(find.text(AppStrings.onboardingTitle1), findsOneWidget);
    expect(find.text(AppStrings.onboardingSubtitle1), findsOneWidget);
    expect(find.text(AppStrings.skip), findsOneWidget);
    expect(find.text(AppStrings.next), findsOneWidget);
  });

  testWidgets('Navigating through pages updates content and buttons', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pump(const Duration(milliseconds: 100));

    // Step 1: Tap Next
    await tester.tap(find.widgetWithText(CustomButton, AppStrings.next));
    // Pump frames to complete PageController animation
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    // Step 2: Title 2 and back icon are visible
    expect(find.text(AppStrings.onboardingTitle2), findsOneWidget);
    expect(find.text(AppStrings.skip), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

    // Tap Back
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    // Back to Step 1
    expect(find.text(AppStrings.onboardingTitle1), findsOneWidget);

    // Advance to Step 2 then Step 3
    await tester.tap(find.widgetWithText(CustomButton, AppStrings.next));
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    await tester.tap(find.widgetWithText(CustomButton, AppStrings.next));
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    // Step 3: Title 3 and Get Started button visible, Skip hidden
    expect(find.text(AppStrings.onboardingTitle3), findsOneWidget);
    expect(find.widgetWithText(CustomButton, AppStrings.getStarted), findsOneWidget);
    expect(find.text(AppStrings.skip), findsNothing);
  });
}
