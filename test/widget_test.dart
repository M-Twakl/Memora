import 'package:flutter_test/flutter_test.dart';
import 'package:memora/features/splash/presentation/views/splash_view.dart';
import 'package:memora/main.dart';

void main() {
  testWidgets('MemoraApp initializes and renders SplashView', (WidgetTester tester) async {
    await tester.pumpWidget(const MemoraApp());
    expect(find.byType(SplashView), findsOneWidget);
  });
}
