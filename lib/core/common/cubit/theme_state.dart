import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  const ThemeState({this.themeMode = ThemeMode.light});

  factory ThemeState.initial() => const ThemeState();

  final ThemeMode themeMode;

  ThemeState copyWith({
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object> get props => [themeMode];

  @override
  String toString() => 'ThemeState(appTheme: $themeMode)';
}
