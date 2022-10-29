import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youtube_sample_app/common/widget/widget_key.dart';
import 'package:youtube_sample_app/features/setting/presentation/ui/setting_screen.dart';

void main() {

  testWidgets('setting screen dialog no...', (tester) async {

    await tester.pumpWidget(
      const MaterialApp(
          home: SettingScreen(),
          ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Setting Screen'), findsOneWidget);

    final logoutBtn = find.byKey(btnLogoutKey);
    expect(logoutBtn, findsOneWidget);

    await tester.tap(logoutBtn);
    await tester.pumpAndSettle();
    expect(find.text('Do you want to logout?'), findsOneWidget);

    await tester.tap(find.byKey(btnNoKey));
    await tester.pumpAndSettle();
    expect(find.text('Do you want to logout?'), findsNothing);
    expect(find.text('Setting Screen'), findsOneWidget);

  });
}
