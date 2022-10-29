

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterState {
  final AsyncValue<bool> isRegistered;
  final bool isFormValid;

  RegisterState(this.isRegistered, this.isFormValid);

  

  RegisterState copyWith({
    AsyncValue<bool>? isRegistered,
    bool? isFormValid,
  }) {
    return RegisterState(
      isRegistered ?? this.isRegistered,
      isFormValid ?? this.isFormValid,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RegisterState &&
      other.isRegistered == isRegistered &&
      other.isFormValid == isFormValid;
  }

  @override
  int get hashCode => isRegistered.hashCode ^ isFormValid.hashCode;

  @override
  String toString() => 'RegisterState(isRegistered: $isRegistered, isFormValid: $isFormValid)';
}
