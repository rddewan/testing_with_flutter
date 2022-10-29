
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube_sample_app/core/remote/network_service.dart';
import 'package:youtube_sample_app/features/auth/data/dto/request/login/login_request.dart';
import 'package:youtube_sample_app/features/auth/data/dto/response/login_response.dart';


part 'auth_api_service.g.dart';

final authApiServiceProvider = Provider.autoDispose<AuthApiService>((ref) {
  final dio = ref.watch(networkServiceProvider);

  return AuthApiService(dio);
  
});

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio) => _AuthApiService(dio);

  @POST('api/v1/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

}