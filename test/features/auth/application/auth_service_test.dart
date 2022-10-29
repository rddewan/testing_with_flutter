import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/core/local/db/hive_box_key.dart';
import 'package:youtube_sample_app/features/auth/application/auth_service.dart';
import 'package:youtube_sample_app/features/auth/data/repository/iauth_repository.dart';
import 'package:youtube_sample_app/features/setting/data/repository/setting_repository.dart';

import '../../../../test_data/login/login_request_test.dart';
import '../../../../test_data/login/login_response_test.dart';
import 'auth_service_test.mocks.dart';


@GenerateNiceMocks([MockSpec<IAuthRepository>(), MockSpec<ISettingRepository>()])

void main() {
  late MockIAuthRepository mockAuthRepository;
  late MockISettingRepository mockSettingRepository;

  setUp(() {
    mockAuthRepository = MockIAuthRepository();
    mockSettingRepository = MockISettingRepository();

  });

  test('Give login request When login Then return success', () async {
    
    when(mockSettingRepository.addToBox<String>(accessTokenKey,loginResponseTest.accessToken))
      .thenAnswer((_) async => true);

    when(mockAuthRepository.login(loginRequestTest))
      .thenAnswer((_) async => loginResponseTest);

    final authService = AuthService(mockAuthRepository, mockSettingRepository);
    final response = await authService.login(loginRequestTest);

    expect(response.getSuccess(), true); 
    expect(response.isSuccess(), true);    
    expect(response, isA<Result>());
    expect(response.getError(),null);    
    verify(mockAuthRepository.login(loginRequestTest)).called(1);


  });

  test('Given login response When login Then return error', () async {

    when(mockAuthRepository.login(loginRequestTest))
      .thenThrow(Failure(message: 'message', stackTrace: StackTrace.fromString('stackTraceString')));

    final authService = AuthService(mockAuthRepository, mockSettingRepository);
    final response = await authService.login(loginRequestTest);

    expect(response.isError(), true);
    expect(
      response.getError(), 
      Failure(
        message: 'message', 
        stackTrace: StackTrace.fromString('stackTraceString'),
      ),
    );

    verify(mockAuthRepository.login(loginRequestTest)).called(1);


  });

  test('Given accessTokenKey with null value  When addToBox Then return true', () async {

    when(mockSettingRepository.addToBox<String>(accessTokenKey,null))
      .thenAnswer((_) async => true);

    final authService = AuthService(mockAuthRepository, mockSettingRepository);
    final response = await authService.logout();

    expect(response.isError(), false);
    expect(response.getSuccess(), true);

    verify(mockSettingRepository.addToBox(accessTokenKey,null)).called(1);


  });

  test('Given accessTokenKey  When addToBox Then return accessTokenKey', () async {

    when(mockSettingRepository.getFromBox<String>(accessTokenKey))
      .thenAnswer((_) async => loginResponseTest.accessToken);

    final authService = AuthService(mockAuthRepository, mockSettingRepository);
    final response = await authService.getFromBox<String>(accessTokenKey);

    expect(response, isNotNull);
    expect(response, loginResponseTest.accessToken);
    verify(mockSettingRepository.getFromBox(accessTokenKey)).called(1);


  });

  test('Given accessTokenKey  When addToBox Then return error', () async {

    when(mockSettingRepository.getFromBox<String>(accessTokenKey))
      .thenThrow(Error(Failure(message: 'message', stackTrace: StackTrace.fromString('stackTraceString'))));

    final authService = AuthService(mockAuthRepository, mockSettingRepository);
    //final response = await authService.getFromBox<String>(accessTokenKey);

    expect(()=> authService.getFromBox<String>(accessTokenKey), throwsException);   
    verify(mockSettingRepository.getFromBox(accessTokenKey)).called(1);


  });

}