

class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterRequest(this.name, this.email, this.password, this.confirmPassword);

  @override
  String toString() {
    return 'RegisterRequest(name: $name, email: $email, password: $password, confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RegisterRequest &&
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.confirmPassword == confirmPassword;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      confirmPassword.hashCode;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      map['name'] ?? '',
      map['email'] ?? '',
      map['password'] ?? '',
      map['password_confirmation'] ?? '',
    );
  }
  
  factory RegisterRequest.fromJson(Map<String, dynamic> json) => RegisterRequest.fromMap(json);
}
