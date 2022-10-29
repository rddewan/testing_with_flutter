import 'dart:async';

import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/features/register/data/dto/request/register_request.dart';


abstract class IRegisterService {  
  Future<Result<Failure,bool>> register(RegisterRequest request);  
  Future<bool> addToBox<T>(String key, T? value);
  
}