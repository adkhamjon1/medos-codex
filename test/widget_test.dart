import 'package:flutter_test/flutter_test.dart';

import 'package:medos/main.dart';

void main() {
  testWidgets('Medos shows calculator and prescription tabs', (tester) async {
    await tester.pumpWidget(const MedosApp());

    expect(find.text('Medos'), findsOneWidget);
    expect(find.text('Doza hisoblash'), findsOneWidget);
    expect(find.text('180 mg'), findsOneWidget);
    expect(find.text('540 mg'), findsOneWidget);

    await tester.tap(find.text('Retsept'));
    await tester.pumpAndSettle();

    expect(find.text('Retsept'), findsWidgets);
    expect(find.textContaining('Paratsetamol'), findsWidgets);
  });

  testWidgets('Medos shows protocol list', (tester) async {
    await tester.pumpWidget(const MedosApp());

    await tester.tap(find.text('Protokol'));
    await tester.pumpAndSettle();

    expect(find.text('Protokollar'), findsOneWidget);
    expect(find.text('Isitma'), findsOneWidget);
    expect(find.text('Yo\'tal'), findsOneWidget);
  });
}
