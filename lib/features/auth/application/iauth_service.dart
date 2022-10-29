import 'dart:async';

import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/features/auth/data/dto/request/login/login_request.dart';


abstract class IAuthService {  
  Future<Result<Failure,bool>> login(LoginRequest request);
  Future<Result<Failure,bool>> logout();
  Future<bool> addToBox<T>(String key, T? value);
  Future<T?> getFromBox<T>(String key);

}