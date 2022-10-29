
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:youtube_sample_app/common/widget/widget_key.dart';
import 'package:youtube_sample_app/core/local/db/hive_db.dart';
import 'package:youtube_sample_app/main.dart';

import '../test_data/register/register_request_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  

  setUp(() async{
    container = ProviderContainer();
    final db = container.read(hiveDbProvider);
    await db.init();

  });

  tearDown(() {
    container.dispose();   

  });

  testWidgets('Auth Flow', (WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container, 
        child: const MyApp(),
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
    
    await tester.tap(find.byKey(registerNowTextKey));
    await tester.pumpAndSettle();
    expect(find.text('Register'), findsNWidgets(3));

    final nameTextFiled = find.byKey(nameTextKey);
    await tester.enterText(nameTextFiled, registerRequestValid.name);

    final emailTextFiled = find.byKey(emailTextKey);
    await tester.enterText(emailTextFiled, registerRequestValid.email);

    final passwordTextFiled = find.byKey(passwordTextKey);
    await tester.enterText(passwordTextFiled, registerRequestValid.password);

    final confirmPasswordTextFiled = find.byKey(confirmPasswordTextKey);
    await tester.enterText(confirmPasswordTextFiled, registerRequestValid.confirmPassword);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsNWidgets(3));

    //await tester.tap(find.byKey(btnRegister));
    //await tester.pumpAndSettle();

  });
  
}