
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/features/register/data/api/register_api_service.dart';
import 'package:youtube_sample_app/features/register/data/dto/response/register_response.dart';
import 'package:youtube_sample_app/features/register/data/dto/request/register_request.dart';
import 'package:youtube_sample_app/features/register/data/repository/iregister_repository.dart';



final registerRepositoryProvider = Provider.autoDispose<IRegisterRepository>((ref) {
  final registerApiService = ref.watch(registerApiServiceProvider);

  return RegisterRepository(registerApiService);

});

class RegisterRepository implements IRegisterRepository {
  final RegisterApiService _registerApiService;

  RegisterRepository(this._registerApiService);


  @override
  Future<RegisterResponse> register(RegisterRequest request) async{
     try {

      return await _registerApiService.register(request);

    } on DioError catch (e,s){

      if (e.error is SocketException) {
        throw Failure(message: e.message, stackTrace: s);
      }      
      
      throw Failure(
          message: e.response?.data.toString() ?? 'Something went wrong',
          code: e.response?.statusCode,
          exception: e,
          stackTrace: s,
      );
    }
    
  }

}