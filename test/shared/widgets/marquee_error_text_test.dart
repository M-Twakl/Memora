import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memora/core/constants/app_strings.dart';
import 'package:memora/shared/widgets/marquee_error_text.dart';

void main() {
  testWidgets('MarqueeErrorText renders short text statically', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 400,
            child: MarqueeErrorText(errorText: 'Short error'),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Short error'), findsOneWidget);
    final marqueeFinder = find.byType(MarqueeErrorText);
    expect(
      find.descendant(of: marqueeFinder, matching: find.byType(Transform)),
      findsNothing,
    );
  });

  testWidgets('MarqueeErrorText wraps overflowing text in ClipRect and animated Transform', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 100, // Small width forces text to overflow
            child: MarqueeErrorText(
              errorText: 'Phone number must start with 010, 011, 012, or 015',
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Phone number must start with 010, 011, 012, or 015'), findsOneWidget);
    final marqueeFinder = find.byType(MarqueeErrorText);
    expect(
      find.descendant(of: marqueeFinder, matching: find.byType(SingleChildScrollView)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: marqueeFinder, matching: find.byType(Transform)),
      findsAtLeastNWidgets(1),
    );
  });

  testWidgets('MarqueeErrorText moves password length validation message on phone-sized width', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 350, // Typical phone text field available width
            child: MarqueeErrorText(
              errorText: AppStrings.passwordLength,
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text(AppStrings.passwordLength), findsOneWidget);
    final marqueeFinder = find.byType(MarqueeErrorText);
    // Verifies it activates marquee animation on the password length message
    expect(
      find.descendant(of: marqueeFinder, matching: find.byType(Transform)),
      findsAtLeastNWidgets(1),
    );
  });
}
