import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/common/widget/widget_key.dart';
import 'package:youtube_sample_app/features/register/application/register_service.dart';
import 'package:youtube_sample_app/features/register/presentation/controller/register_controller.dart';
import 'package:youtube_sample_app/features/register/presentation/state/register_state.dart';
import 'package:youtube_sample_app/features/register/presentation/ui/register_screen.dart';

import '../../../../../test_data/register/register_request_test.dart';
import 'register_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RegisterService>()])
void main() {
  
  late MockRegisterService mockRegisterService;
 
  setUp(() async {
    //await setUpTestHive();
    mockRegisterService = MockRegisterService();
    

  });

  tearDown(() async {
    //await tearDownTestHive();
  });

  testWidgets('register screen ...', (tester) async {
    
    final mockRegisterController = StateNotifierProvider.autoDispose<RegisterController,RegisterState>((ref) {
      
      final controller = RegisterController(
        mockRegisterService, 
        RegisterState(const AsyncValue.data(false), false),
      );

      return controller;

    });

    when(mockRegisterService.register(registerRequestValid),
    ).thenAnswer((_) async => const Success(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          registerControllerProvider.overrideWithProvider(mockRegisterController)
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: RegisterScreen(),
          ),
        ),
      ),
    );

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

    await tester.tap(find.byKey(btnRegisterKey));
    await tester.pumpAndSettle();
    expect( find.text('Register successful'), findsOneWidget);




  });
}