import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/features/auth/data/api/auth_api_service.dart';
import 'package:youtube_sample_app/features/auth/data/dto/response/login_response.dart';
import 'package:youtube_sample_app/features/auth/data/repository/auth_repository.dart';

import '../../../../../test_data/login/login_request_test.dart';
import '../../../../../test_data/login/login_response_test.dart';
import 'auth_repository_test.mocks.dart';


@GenerateNiceMocks([MockSpec<AuthApiService>()])
//class MockAuthApiService  extends Mock implements AuthApiService{}

void main() {
  late AuthApiService mockAuthApiService;

  setUp(() {
    mockAuthApiService = MockAuthApiService();

  });

  test('Give AuthRepository When login Then return success LoginResponse', () async {
    // Given
    final repository = AuthRepository(mockAuthApiService);
    // When
    when(mockAuthApiService.login(loginRequestTest))
      .thenAnswer((_) async => loginResponseTest);

    final response = await  repository.login(loginRequestTest);
    
    // Then
    expect(response, loginResponseTest);
    expect(response, isA<LoginResponse>());
    verify(mockAuthApiService.login(loginRequestTest)).called(1);


  });

  test('Give AuthRepository When login Then throw Failure', () async {
    // Given
    final repository = AuthRepository(mockAuthApiService);

    // When
    when(mockAuthApiService.login(loginRequestTest))
      .thenThrow(Failure(message: 'message', stackTrace: StackTrace.fromString('stackTraceString')));

       
    // Then   
    expect(repository.login(loginRequestTest), throwsA(isA<Failure>()));
    verify(mockAuthApiService.login(loginRequestTest)).called(1);

  });

  test('Give AuthRepository When login Then throw SocketException', () async {
    // Given
    final repository = AuthRepository(mockAuthApiService);

    // When
    when(mockAuthApiService.login(loginRequestTest))
      .thenThrow(const SocketException('message'));

       
    // Then   
    expect(repository.login(loginRequestTest), throwsA(isA<SocketException>()));
    verify(mockAuthApiService.login(loginRequestTest)).called(1);

  });
}