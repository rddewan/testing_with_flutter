
class RegisterResponse {
  final int id;
  final String name;
  final String email;
  final DateTime updatedAt;
  final DateTime createdAt;

  RegisterResponse(this.id, this.name, this.email, this.updatedAt, this.createdAt);


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RegisterResponse &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.updatedAt == updatedAt &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode;
  }

  @override
  String toString() {
    return 'RegisterResponse(id: $id, name: $name, email: $email, updatedAt: $updatedAt, createdAt: $createdAt)';
  }

  RegisterResponse copyWith({
    int? id,
    String? name,
    String? email,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return RegisterResponse(
      id ?? this.id,
      name ?? this.name,
      email ?? this.email,
      updatedAt ?? this.updatedAt,
      createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory RegisterResponse.fromMap(Map<String, dynamic> map) {
    return RegisterResponse(
      map['id']?.toInt() ?? 0,
      map['name'] ?? '',
      map['email'] ?? '',
      DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
      DateTime.fromMillisecondsSinceEpoch(map['created_at']),
    );
  }

  

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse.fromMap(json);
}
