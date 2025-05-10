import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_toast/smart_toast.dart';

void main() {
  testWidgets('SmartToast shows SnackBar with success icon', (WidgetTester tester) async {
    final testKey = Key('show_toast');

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                key: testKey,
                onPressed: () {
                  SmartToast.show(context, "Profile updated!");
                },
                child: Text("Show"),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(testKey));
    await tester.pump(); // Start animation
    await tester.pump(const Duration(seconds: 1)); // Let the SnackBar appear

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Profile updated!'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });
}
