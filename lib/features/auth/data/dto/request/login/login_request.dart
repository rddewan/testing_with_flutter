
import 'package:flutter/foundation.dart';

@immutable
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});

  @override
  String toString() => 'LoginRequest(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LoginRequest &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;



  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
 

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest.fromMap(json);
}
