


import 'package:youtube_sample_app/features/register/data/dto/request/register_request.dart';
import 'package:youtube_sample_app/features/register/data/dto/response/register_response.dart';

abstract class IRegisterRepository {
  Future<RegisterResponse> register(RegisterRequest request);
}