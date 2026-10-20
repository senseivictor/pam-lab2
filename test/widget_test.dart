import 'package:flutter_test/flutter_test.dart';
import 'package:lab2_pam/app.dart';
import 'package:lab2_pam/screens/home_screen.dart';

void main() {
  testWidgets('fitness home screen loads', (tester) async {
    await tester.pumpWidget(const FitnessApp());

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Good Morning'), findsOneWidget);
    expect(find.text('Massive Upper Body'), findsOneWidget);
  });
}
