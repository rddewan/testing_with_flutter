

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/features/auth/data/dto/request/login/login_request.dart';



class LoginState {
  final AsyncValue<bool> isLoggedIn;
  final LoginRequest? loginRequest;

  LoginState(this.isLoggedIn, this.loginRequest);


  

  LoginState copyWith({
    AsyncValue<bool>? isLoggedIn,
    LoginRequest? loginRequest,
  }) {
    return LoginState(
      isLoggedIn ?? this.isLoggedIn,
      loginRequest ?? this.loginRequest,
    );
  }

  @override
  String toString() => 'LoginState(isLoggedIn: $isLoggedIn, loginRequest: $loginRequest)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LoginState &&
      other.isLoggedIn == isLoggedIn &&
      other.loginRequest == loginRequest;
  }

  @override
  int get hashCode => isLoggedIn.hashCode ^ loginRequest.hashCode;
}
