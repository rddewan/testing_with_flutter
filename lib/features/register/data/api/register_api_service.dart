
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube_sample_app/core/remote/network_service.dart';
import 'package:youtube_sample_app/features/register/data/dto/request/register_request.dart';
import 'package:youtube_sample_app/features/register/data/dto/response/register_response.dart';


part 'register_api_service.g.dart';

final registerApiServiceProvider = Provider.autoDispose<RegisterApiService>((ref) {
  final dio = ref.watch(networkServiceProvider);

  return RegisterApiService(dio);
  
});

@RestApi()
abstract class RegisterApiService {
  factory RegisterApiService(Dio dio) => _RegisterApiService(dio);

  @POST('api/v1/register')
  Future<RegisterResponse> register(@Body() RegisterRequest request);

}