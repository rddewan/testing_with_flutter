
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/features/auth/data/api/auth_api_service.dart';
import 'package:youtube_sample_app/features/auth/data/dto/request/login/login_request.dart';
import 'package:youtube_sample_app/features/auth/data/dto/response/login_response.dart';
import 'package:youtube_sample_app/features/auth/data/repository/iauth_repository.dart';



final authRepositoryProvider = Provider.autoDispose<IAuthRepository>((ref) {
  final loginApiService = ref.watch(authApiServiceProvider);

  return AuthRepository(loginApiService);

});

class AuthRepository implements IAuthRepository {
  final AuthApiService _loginApiService;

  AuthRepository(this._loginApiService);
  
  @override
  Future<LoginResponse> login(LoginRequest request) async {

    try {

      return await _loginApiService.login(request);

    } on DioError catch (e,s){

      if (e.error is SocketException) {
        throw Failure(message: e.message, stackTrace: s);
      }      
      
      throw Failure(
          message: e.response?.statusMessage ?? 'Something went wrong',
          code: e.response?.statusCode,
          exception: e,
          stackTrace: s,
      );
    }
    
    
  }

}