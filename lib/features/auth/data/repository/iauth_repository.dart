

import 'package:youtube_sample_app/features/auth/data/dto/request/login/login_request.dart';
import 'package:youtube_sample_app/features/auth/data/dto/response/login_response.dart';

abstract class IAuthRepository {
  Future<LoginResponse> login(LoginRequest request);
}