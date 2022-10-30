import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/features/register/application/register_service.dart';
import 'package:youtube_sample_app/features/register/presentation/controller/register_controller.dart';
import 'package:youtube_sample_app/features/register/presentation/state/register_state.dart';

import '../../../../../test_data/register/register_request_test.dart';
import 'register_controller_test.mocks.dart';


@GenerateNiceMocks([MockSpec<RegisterService>()])

void main() {
  late RegisterService mockRegisterService;

  setUp(() async {
    await setUpTestHive();
    mockRegisterService = MockRegisterService();

  });

  tearDown(() async {
    await tearDownTestHive();
  });

  group('register controller test', () {

    test('register success', () async {
      // Setup      
      when(mockRegisterService.register(registerRequestValid))
      .thenAnswer((_) async => const Success(true));

      final controller = RegisterController(
        mockRegisterService, RegisterState(const AsyncValue.data(false), false,false),
      );

      expect(controller.debugState.isRegistered, const AsyncValue.data(false));
      
      // Run
      controller.register(registerRequestValid);
      
      // Verify
      expect(controller.debugState.isRegistered, const AsyncValue<bool>.loading());
      
      await controller.stream.firstWhere((state) {
        if (state.isRegistered.hasValue) return true;
        return false;
      });
      
      expect(controller.debugState.isRegistered, const AsyncValue.data(true));      
      verify(mockRegisterService.register(registerRequestValid)).called(1);
      

    });


    test('register error', () async {
      // Setup      
      when(mockRegisterService.register(registerRequestValid))
        .thenAnswer((_) async => Error(
          Failure(
            message: 'something went wrong',
            stackTrace: StackTrace.fromString('stackTraceString'),
          ),
        ),
      );

      final controller = RegisterController(
        mockRegisterService, RegisterState(const AsyncValue.data(false), false,false),
      );

      expect(controller.debugState.isRegistered, const AsyncValue.data(false));

           
      // Run
      controller.register(registerRequestValid);
      
      // Verify
      expect(controller.debugState.isRegistered, const AsyncValue<bool>.loading());
      
      await controller.stream.firstWhere((state) {
        if (state.isRegistered.hasError) return true;
        return false;
      });
      
      expect(controller.debugState.isRegistered, isA<AsyncValue>());   
      expect(controller.debugState.isRegistered.hasError, true);  
      // expect(controller.debugState.isRegistered, AsyncValue<bool>.error(
      //   Failure(
      //       message: 'something went wrong',
      //       stackTrace: StackTrace.fromString('stackTraceString'),
      //     ),
      //     StackTrace.fromString('stackTraceString')
      // ));
      verify(mockRegisterService.register(registerRequestValid)).called(1);
      

    });

  });
  
}