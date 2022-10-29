import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/core/local/db/hive_box_key.dart';
import 'package:youtube_sample_app/features/register/application/iregister_service.dart';
import 'package:youtube_sample_app/features/register/data/dto/request/register_request.dart';
import 'package:youtube_sample_app/features/register/data/repository/iregister_repository.dart';
import 'package:youtube_sample_app/features/register/data/repository/register_reposititory.dart';
import 'package:youtube_sample_app/features/setting/data/repository/setting_repository.dart';
import 'package:youtube_sample_app/features/setting/data/repository/setting_repository_impl.dart';


final registerServiceProvider = Provider.autoDispose<IRegisterService>((ref) {
  final registerRepository = ref.watch(registerRepositoryProvider);
  final settingRepository = ref.watch(settingRepositoryProvider);

  return RegisterService(registerRepository,settingRepository);

});

class RegisterService implements IRegisterService {  
  final IRegisterRepository _registerRepository;
  final ISettingRepository _settingRepository;
  

  RegisterService(this._registerRepository, this._settingRepository);
  

  @override
  Future<Result<Failure, bool>> register(RegisterRequest request) async{
    try {

      final response  = await _registerRepository.register(request);

      final result = await addToBox(userIdKey,response.id);
            
      return Success(result);
      
    } on Failure catch (e) {
      return Error(e);
    }
  }
  

  @override
  Future<bool> addToBox<T>(String key, T? value) async {
    try {      

      return  await _settingRepository.addToBox(userIdKey, value);    
      
    } on Exception catch (e,s) {
      throw Failure(message: e.toString(),stackTrace: s); 
    }
  }
  
  
  
  
}