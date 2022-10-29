import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/core/local/db/hive_box_key.dart';
import 'package:youtube_sample_app/features/auth/application/iauth_service.dart';
import 'package:youtube_sample_app/features/auth/presentation/ui/controller/auth_controller.dart';
import 'package:youtube_sample_app/features/auth/presentation/ui/state/login_state.dart';

import '../../../../../../test_data/login/login_request_test.dart';
import '../../../../../../test_data/login/login_response_test.dart';
import 'auth_controller_test.mocks.dart';


@GenerateNiceMocks([MockSpec<IAuthService>()])

void main() {
  late IAuthService mockIAuthService;

  setUp(() {
    mockIAuthService = MockIAuthService();

  });

  test('Given loginRequest when login Then return true', () async {

    when(mockIAuthService.login(loginRequestTest))
      .thenAnswer((_) async => const Success(true));

    final controller = AuthController(
      mockIAuthService, 
      LoginState(const AsyncLoading(),null),
    );

    expect(controller.debugState.isLoggedIn,  const AsyncLoading<bool>());
    expectLater(controller.authStream.stream, emits(true));

    
    
    controller.login(loginRequestTest);   
    
    await controller.stream.firstWhere((state) {
      if (state.isLoggedIn.hasValue) return true;

      return false;
    });

    expect(controller.debugState.isLoggedIn,  const AsyncData<bool>(true));
    verify(mockIAuthService.login(loginRequestTest)).called(1);
   

  });

  test('Given loginRequest When login Then return  error', () async {
    when(mockIAuthService.login(loginRequestTest))
      .thenAnswer((_) async => Error(
        Failure(message: '',stackTrace: StackTrace.fromString('stackTraceString')),),
      );

    final controller = AuthController(mockIAuthService, LoginState(const AsyncLoading(),null));
    expect(controller.debugState.isLoggedIn, const AsyncLoading<bool>());
   
    controller.login(loginRequestTest);
    expect(controller.debugState.isLoggedIn, const AsyncLoading<bool>());
    
    await controller.stream.firstWhere((state) {
      if (state.isLoggedIn.hasError) return true;

      return false;      
    },); 

    expect(controller.debugState.isLoggedIn,  isA<AsyncError>());
    verify(mockIAuthService.login(loginRequestTest)).called(1);
    

  });

  test('Given access token null When logout Then return  true', () async {
   
    when(mockIAuthService.logout())
      .thenAnswer((_) async => const Success(true));
    
    final controller = AuthController(
      mockIAuthService, 
      LoginState(const AsyncLoading(),null),
    );

    expect(controller.debugState.isLoggedIn, const AsyncLoading<bool>());
    expectLater(controller.authStream.stream, emits(false));
    controller.logout();

    await controller.stream.firstWhere((state) {
      if (state.isLoggedIn.hasValue ) return true;

      return false;      
    },); 
       
    expect(controller.debugState.isLoggedIn,  isA<AsyncData>());
    expect(controller.debugState.isLoggedIn,  const AsyncData<bool>(false));

    controller.authStream.stream.listen((event) {
      expectAsync1((value) => expect(value, false));
      
    });
  });

  test('Given accessTokenKey When readFromBox Then return  true', () async {
   
    when(mockIAuthService.getFromBox<String>(accessTokenKey))
      .thenAnswer((_) async => loginResponseTest.accessToken);
    
    final controller = AuthController(
      mockIAuthService, 
      LoginState(const AsyncLoading(),null),
    );

    expect(controller.debugState.isLoggedIn, const AsyncLoading<bool>());
    //expect later
    expectLater(controller.authStream.stream, emits(true));

    controller.getAccessToken();

    await controller.stream.firstWhere((state) {
      if (state.isLoggedIn.hasValue ) return true;

      return false;      
    },); 
       
    expect(controller.debugState.isLoggedIn,  isA<AsyncData>());
    expect(controller.debugState.isLoggedIn,  const AsyncData<bool>(true));
    verify(mockIAuthService.getFromBox<String>(accessTokenKey)).called(1);
    

    
  });

  test('Given loginRequest when dispose Then throwStateError', () {
    when(mockIAuthService.login(loginRequestTest))
      .thenAnswer((_) async => const Success(true));

    final controller = AuthController(
      mockIAuthService, 
      LoginState(const AsyncLoading(),null),
    );

    controller.dispose();

    expect(() => controller.login(loginRequestTest), throwsStateError);

  });


}