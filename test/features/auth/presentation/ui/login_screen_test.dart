import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/common/widget/widget_key.dart';

import 'package:youtube_sample_app/features/auth/application/iauth_service.dart';
import 'package:youtube_sample_app/features/auth/presentation/ui/controller/auth_controller.dart';
import 'package:youtube_sample_app/features/auth/presentation/ui/login_screen.dart';
import 'package:youtube_sample_app/features/auth/presentation/ui/state/login_state.dart';
import '../../../../../test_data/login/login_request_test.dart';


import 'controller/auth_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IAuthService>()])

void main() {
  late IAuthService mockIAuthService;
  

  setUp(() {
    mockIAuthService = MockIAuthService();
    
  });

  group('Login screen test', () {

      testWidgets('login screen with password validation error ', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: LoginScreen(),
          ),
        );
        await tester.pump();
        expect(find.text('Login'), findsNWidgets(3));

        final emailField = find.byKey(emailTextKey);
        expect(emailField, findsOneWidget);
        await tester.enterText(emailField,'demo@gmial.com');

        final passwordField = find.byKey(passwordTextKey);
        expect(passwordField, findsOneWidget);
        await tester.enterText(passwordField,'12345');

        expect(find.text("Don't have a account?"), findsOneWidget);
        expect(find.byKey(registerNowTextKey),findsOneWidget);

        final loginBtn = find.byKey(btnLoginKey);
        expect(loginBtn, findsOneWidget);

        await tester.tap(loginBtn);
        await tester.pumpAndSettle();

        expect(find.text('password is invalid'), findsOneWidget);

    
      });

    testWidgets('login screen with email and password validation success ', (tester) async {
       
        when(mockIAuthService.login(loginRequestTest))
          .thenAnswer((_) async => const Success(true));

        final mockAuthControllerProvider = StateNotifierProvider.autoDispose<AuthController,LoginState>((ref) {
          final controller =  AuthController(mockIAuthService, LoginState(const AsyncLoading(),null));
          return controller;
        });
        
        await tester.pumpWidget(
          ProviderScope (
          overrides: [
            authControllerProvider.overrideWithProvider(mockAuthControllerProvider)
          ],
          child: const MaterialApp(
            home: LoginScreen(),
          ),
        ),
        );
        await tester.pump();
        expect(find.text('Login'), findsNWidgets(3));

        final emailField = find.byKey(emailTextKey);
        expect(emailField, findsOneWidget);
        await tester.enterText(emailField,loginRequestTest.email);

        final passwordField = find.byKey(passwordTextKey);
        expect(passwordField, findsOneWidget);
        await tester.enterText(passwordField,loginRequestTest.password);
       
        final loginBtn = find.byKey(btnLoginKey);
        expect(loginBtn, findsOneWidget);

        await tester.tap(loginBtn);
        await tester.pumpAndSettle();

        expect(find.text('email is empty'), findsNothing);
        expect(find.text('password is empty'), findsNothing);
        expect(find.text('password is invalid'), findsNothing);
        expect(find.text('email is invalid'), findsNothing);

    
      });

    testWidgets('login screen icon test', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );
      await tester.pump();  

      expect(find.byIcon(Icons.security), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsNWidgets(2));
      expect(find.byType(IconButton), findsNWidgets(2));


     });

  });

  
}