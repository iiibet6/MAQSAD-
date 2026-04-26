import 'package:flutter_test/flutter_test.dart';
import 'package:maqsad/main.dart';

void main() {
  testWidgets('Maqsad app loads successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaqsadApp());

    expect(find.byType(MaqsadApp), findsOneWidget);
  });
}