
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youtube_sample_app/common/widget/widget_key.dart';
import 'package:youtube_sample_app/features/auth/presentation/ui/login_screen.dart';

void main() {

  testWidgets('login screen ...', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
      
   );
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsNWidgets(3));

    final emailField = find.byKey(emailTextKey);
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, 'demo1@gmail.com');

    final passwordField = find.byKey(passwordTextKey);
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, '123456');
   
    await tester.tap(find.byKey(btnLoginKey));
    await tester.pumpAndSettle();
    expect(find.text('email is empty'), findsNothing);
    expect(find.text('password is empty'), findsNothing);
       
  });

  testWidgets('login screen ...', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
      
   );
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsNWidgets(3));

    final emailField = find.byKey(emailTextKey);
    expect(emailField, findsOneWidget);
    
    final passwordField = find.byKey(passwordTextKey);
    expect(passwordField, findsOneWidget);   

    
    await tester.tap(find.byKey(btnLoginKey));
    await tester.pumpAndSettle();
    expect(find.text('email is empty'), findsOneWidget);
    expect(find.text('password is empty'), findsOneWidget);
       
  });
}