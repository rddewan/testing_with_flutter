import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/core/local/db/hive_box_key.dart';
import 'package:youtube_sample_app/features/auth/application/iauth_service.dart';
import 'package:youtube_sample_app/features/auth/data/dto/request/login/login_request.dart';
import 'package:youtube_sample_app/features/auth/data/repository/iauth_repository.dart';
import 'package:youtube_sample_app/features/auth/data/repository/auth_repository.dart';
import 'package:youtube_sample_app/features/setting/data/repository/setting_repository.dart';
import 'package:youtube_sample_app/features/setting/data/repository/setting_repository_impl.dart';


final authServiceProvider = Provider.autoDispose<IAuthService>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final settingRepository = ref.watch(settingRepositoryProvider);

  final authService = AuthService(authRepository,settingRepository);

  return authService;
});

class AuthService implements IAuthService {  
  final IAuthRepository _authRepository;
  final ISettingRepository _settingRepository;
  

  AuthService(this._authRepository, this._settingRepository);
  
  @override
  Future<Result<Failure, bool>> login(LoginRequest request) async {
    try {

      final response  = await _authRepository.login(request);

      final result = await addToBox(accessTokenKey,response.accessToken);
            
      return Success(result);
      
    } on Failure catch (e) {
      return Error(e);
    }
  }
  
    
  @override
  Future<Result<Failure, bool>> logout() async {
    try {      

      final result = await addToBox(accessTokenKey,null);      
      return Success(result);
      
    } on Failure catch (e) {
      return Error(e);
    }
  }

  @override
  Future<bool> addToBox<T>(String key, T? value) async {

    try {

      return  await _settingRepository.addToBox(key, value);
      
    } catch (e,s) {
      throw Failure(message: e.toString(),stackTrace: s);      
    }
    
  }

  @override
  Future<T?> getFromBox<T>(String key) async {
    try {

      final result = await _settingRepository.getFromBox<T>(key);
      
      return result;
      
    } catch (e,s) {
      throw Failure(message: e.toString(),stackTrace: s);      
    }  
  }
    
  
}