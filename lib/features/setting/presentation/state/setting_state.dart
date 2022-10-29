
import 'package:flutter/material.dart';

@immutable
class SettingState {
  final String? accessToken;
  final String? theme;

  const SettingState({this.accessToken, this.theme});

  

  @override
  String toString() => 'SettingState(accessToken: $accessToken, theme: $theme)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SettingState &&
      other.accessToken == accessToken &&
      other.theme == theme;
  }

  @override
  int get hashCode => accessToken.hashCode ^ theme.hashCode;

  SettingState copyWith({
    String? accessToken,
    String? theme,
  }) {
    return SettingState(
      accessToken: accessToken ?? this.accessToken,
      theme: theme ?? this.theme,
    );
  }
}
