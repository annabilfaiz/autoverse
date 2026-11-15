import 'package:flutter_test/flutter_test.dart';
import 'package:autoverse/main.dart';

void main() {
  testWidgets('AutoVerse app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AutoVerseApp());
    expect(find.byType(AutoVerseApp), findsOneWidget);
  });
}
