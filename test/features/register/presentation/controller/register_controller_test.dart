
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/core/provider/is_internet_connected_provider.dart';
import 'package:youtube_sample_app/features/register/application/register_service.dart';
import 'package:youtube_sample_app/features/register/presentation/controller/register_controller.dart';
import 'package:youtube_sample_app/features/register/presentation/state/register_state.dart';

import '../../../../../test_data/register/register_request_test.dart';
import 'register_controller_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RegisterService>(), 
  MockSpec<InternetConnectionObserver>(),
])

void main() {
  late RegisterService mockRegisterService;  
  late InternetConnectionObserver mockInternetConnectionObserver;
  late ProviderContainer container;
  

  setUp(() async {   
    mockRegisterService = MockRegisterService();   
    mockInternetConnectionObserver = MockInternetConnectionObserver();
      
    container = ProviderContainer(
      overrides: [
        registerServiceProvider.overrideWithValue(mockRegisterService),              
      ],
    ); 
    
  });

  tearDown(() {
    container.dispose();
  });


  group('register controller test', () {
    

    test('Give valid register request When internet is connected and register Then return success', () async {          
      
      when(mockInternetConnectionObserver.isNetConnected())
        .thenAnswer((_) async => true); 
      
      when(mockRegisterService.register(registerRequestValid))
        .thenAnswer((_) async => const Success(true));
     
      final controller = RegisterController(
        mockRegisterService, 
        mockInternetConnectionObserver, 
        RegisterState(const AsyncValue.data(false), false, false),
      );       

      expect(controller.debugState.isRegistered,const AsyncValue.data(false));

      controller.register(registerRequestValid);
     
      await controller.stream.firstWhere((state) {
        if (state.isRegistered.hasValue) return true;
        return false;

      });

      expect(controller.debugState.isRegistered, const AsyncValue.data(true));      
      verify(mockRegisterService.register(registerRequestValid)).called(1);      

    });


    test('Give valid register request When internet is connected and register Then return error', () async {
      // Setup
      when(mockInternetConnectionObserver.isNetConnected())
        .thenAnswer((_) async => true); 

      when(mockRegisterService.register(registerRequestValid))
        .thenAnswer((_) async => Error(
          Failure(
            message: 'something went wrong',
            stackTrace: StackTrace.fromString('stackTraceString'),
          ),
        ),
      );

      final controller = RegisterController(
        mockRegisterService, 
        mockInternetConnectionObserver, 
        RegisterState(const AsyncValue.data(false), false, false),
      ); 

      expect(controller.debugState.isRegistered,const AsyncValue.data(false));;

      // Run
      controller.register(registerRequestValid);
      
      // Verify     
      await controller.stream.firstWhere((state) {
        if (state.isRegistered.hasError) return true;
        return false;
      });
      
      expect(controller.debugState.isRegistered, isA<AsyncValue>());   
      expect(controller.debugState.isRegistered.hasError, true);      
      verify(mockRegisterService.register(registerRequestValid)).called(1);
      

    });

  });
  
}