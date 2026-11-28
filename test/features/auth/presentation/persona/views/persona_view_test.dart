import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/features/auth/presentation/persona/views/persona_view.dart';
import 'package:memora/features/auth/presentation/persona/widgets/persona_choice_card.dart';
import 'package:memora/features/auth/presentation/persona/widgets/persona_header_section.dart';
import 'package:memora/shared/widgets/custom_button.dart';

void main() {
  Widget buildTestWidget({
    VoidCallback? onNextPressed,
    String? initialSelectedRole,
  }) {
    return MaterialApp(
      home: PersonaView(
        onNextPressed: onNextPressed,
        initialSelectedRole: initialSelectedRole,
      ),
    );
  }

  void setStandardPhoneViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(393 * 3, 852 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  testWidgets(
      'PersonaView renders header, 2 choice cards (Patient & Doctor) and next button',
      (tester) async {
    setStandardPhoneViewport(tester);
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // 1. Header
    expect(find.byType(PersonaHeaderSection), findsOneWidget);
    expect(find.text(AppStrings.personaTitle), findsOneWidget);
    expect(find.text(AppStrings.personaSubtitle), findsOneWidget);

    // 2. Choice cards: exactly 2 cards (Patient and Doctor only)
    expect(find.byType(PersonaChoiceCard), findsNWidgets(2));
    expect(find.text(AppStrings.patientRole), findsOneWidget);
    expect(find.text(AppStrings.doctorRole), findsOneWidget);
    expect(find.text('Parents'), findsNothing);

    // 3. Next action button
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.text(AppStrings.next), findsOneWidget);

    // Initial state: next button is disabled (AppColors.disabledButton)
    final button = tester.widget<CustomButton>(find.byType(CustomButton));
    expect(button.backgroundColor, AppColors.disabledButton);
  });

  testWidgets(
      'Tapping a role selects only one option (single selection) and enables next button',
      (tester) async {
    setStandardPhoneViewport(tester);
    bool nextInvoked = false;

    await tester.pumpWidget(
      buildTestWidget(onNextPressed: () => nextInvoked = true),
    );
    await tester.pumpAndSettle();

    // 1. Tap "Patient"
    await tester.tap(find.text(AppStrings.patientRole));
    await tester.pumpAndSettle();

    // Patient card should be selected, Doctor card should NOT be selected
    final patientCard = tester.widget<PersonaChoiceCard>(
      find.widgetWithText(PersonaChoiceCard, AppStrings.patientRole),
    );
    final doctorCard = tester.widget<PersonaChoiceCard>(
      find.widgetWithText(PersonaChoiceCard, AppStrings.doctorRole),
    );
    expect(patientCard.isSelected, isTrue);
    expect(doctorCard.isSelected, isFalse);

    // Next button should now be enabled (AppColors.primaryBlue)
    var button = tester.widget<CustomButton>(find.byType(CustomButton));
    expect(button.backgroundColor, AppColors.primaryBlue);

    // 2. Tap "Doctor" -> Single selection replaces "Patient" with "Doctor"
    await tester.tap(find.text(AppStrings.doctorRole));
    await tester.pumpAndSettle();

    final updatedPatientCard = tester.widget<PersonaChoiceCard>(
      find.widgetWithText(PersonaChoiceCard, AppStrings.patientRole),
    );
    final updatedDoctorCard = tester.widget<PersonaChoiceCard>(
      find.widgetWithText(PersonaChoiceCard, AppStrings.doctorRole),
    );
    expect(updatedPatientCard.isSelected, isFalse);
    expect(updatedDoctorCard.isSelected, isTrue);

    button = tester.widget<CustomButton>(find.byType(CustomButton));
    expect(button.backgroundColor, AppColors.primaryBlue);

    // 3. Tap "next"
    await tester.tap(find.byType(CustomButton));
    await tester.pumpAndSettle();
    expect(nextInvoked, isTrue);

    // 4. Tap "Doctor" again to deselect
    await tester.tap(find.text(AppStrings.doctorRole));
    await tester.pumpAndSettle();

    final deselectedDoctorCard = tester.widget<PersonaChoiceCard>(
      find.widgetWithText(PersonaChoiceCard, AppStrings.doctorRole),
    );
    expect(deselectedDoctorCard.isSelected, isFalse);

    // Next button should be disabled again
    button = tester.widget<CustomButton>(find.byType(CustomButton));
    expect(button.backgroundColor, AppColors.disabledButton);
  });
}
