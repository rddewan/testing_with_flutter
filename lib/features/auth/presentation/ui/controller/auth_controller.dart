

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/common/mixin/input_validation_mixin.dart';
import 'package:youtube_sample_app/core/local/db/hive_box_key.dart';
import 'package:youtube_sample_app/features/auth/application/iauth_service.dart';
import 'package:youtube_sample_app/features/auth/application/auth_service.dart';
import 'package:youtube_sample_app/features/auth/data/dto/request/login/login_request.dart';
import 'package:youtube_sample_app/features/auth/presentation/ui/state/login_state.dart';


final authControllerProvider = StateNotifierProvider.autoDispose<AuthController,LoginState>((ref) {
  final authService = ref.watch(authServiceProvider);

  return AuthController(authService, LoginState(const AsyncLoading(),null));
});

class AuthController extends StateNotifier<LoginState> with InputValidationMixin{
  final IAuthService _authService;
  final StreamController<bool> _authStream = StreamController.broadcast();
  StreamController<bool> get authStream => _authStream;
  
  AuthController(this._authService,  super.state);

  void login(LoginRequest request) async {
    final login = await _authService.login(request);
   
    login.when(
      (error) => state = state.copyWith(
        isLoggedIn: AsyncValue.error(error, error.stackTrace),
      ), 
      (success)  {
        _authStream.sink.add(true);
        state = state.copyWith(isLoggedIn: AsyncValue.data(success));        
      },
    );

  }

  void logout() async {
    final result = await _authService.logout();   
    result.when(
      (error) {
        state = state.copyWith(
          isLoggedIn: AsyncValue.error(error,error.stackTrace),
        );
      }, 
      (success) {
        _authStream.sink.add(false);
        state = state.copyWith(
          isLoggedIn: const AsyncValue.data(false),
        );
      }); 
  }

  void getAccessToken() async {
    final result = await _authService.getFromBox<String>(accessTokenKey);
    
    if (result != null) {
      _authStream.sink.add(true);
      state = state.copyWith(isLoggedIn: const AsyncValue.data(true));  
    }   

  }

  @override
  void dispose() {
    _authStream.close();
    super.dispose();
  }

  
}