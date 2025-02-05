import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plugilo/core/common/cubit/theme_state.dart';
import 'package:plugilo/data/repo/app_config_repository.dart';

@singleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required AppConfigRepository appConfigRepository})
      : _appConfigRepository = appConfigRepository,
        super(ThemeState.initial()) {
    init();
  }

  final AppConfigRepository _appConfigRepository;

  void init() {
    final theme = _appConfigRepository.loadTheme();
    if (theme != null) {
      if (theme == 'dark') {
        emit(state.copyWith(themeMode: ThemeMode.dark));
      } else {
        emit(state.copyWith(themeMode: ThemeMode.light));
      }
    }
  }

  void setTheme({required ThemeMode themeMode}) {
    _appConfigRepository.saveTheme(themeMode == ThemeMode.light ? 'light' : 'dark');
    emit(state.copyWith(themeMode: themeMode));
  }
}
