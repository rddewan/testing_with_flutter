

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterState {
  final AsyncValue<bool> isRegistered;
  final bool isFormValid;
  final bool isTermsAndCondition;

  RegisterState(this.isRegistered, this.isFormValid, this.isTermsAndCondition);

 

  RegisterState copyWith({
    AsyncValue<bool>? isRegistered,
    bool? isFormValid,
    bool? isTermsAndCondition,
  }) {
    return RegisterState(
      isRegistered ?? this.isRegistered,
      isFormValid ?? this.isFormValid,
      isTermsAndCondition ?? this.isTermsAndCondition,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RegisterState &&
      other.isRegistered == isRegistered &&
      other.isFormValid == isFormValid &&
      other.isTermsAndCondition == isTermsAndCondition;
  }

  @override
  int get hashCode => isRegistered.hashCode ^ isFormValid.hashCode ^ isTermsAndCondition.hashCode;
}
