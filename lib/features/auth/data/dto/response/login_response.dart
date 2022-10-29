import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_id')
  final String tokenId;
  @JsonKey(name: 'user_id')
  final int userId;
  final String name;
  final String email;

  LoginResponse(this.accessToken, this.tokenId, this.userId, this.name, this.email);


  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_id': tokenId,
      'user_id': userId,
      'name': name,
      'email': email,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      map['access_token'] ?? '',
      map['token_id'] ?? '',
      map['user_id']?.toInt() ?? 0,
      map['name'] ?? '',
      map['email'] ?? '',
    );
  }
 

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse.fromMap(json);
}
