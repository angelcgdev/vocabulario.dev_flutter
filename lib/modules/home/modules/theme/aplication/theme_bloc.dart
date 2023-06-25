import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/domain/models/models.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/reapository/theme_reapository.dart';

part 'theme_state.dart';
part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeReapositoryInterface _themeReapository;
  ThemeBloc({
    required ThemeReapositoryInterface themeReapository,
  })  : _themeReapository = themeReapository,
        super(const ThemeState.unknown()) {
    on<ThemeStarted>((event, emit) async {
      emit(const ThemeState.loading());
      final mode = await _themeReapository.getThemeMode();
      emit(ThemeState.loaded(mode ?? ThemeMode.system));
    });
    on<ThemeModeChoosed>((event, emit) async {
      emit(const ThemeState.loading());
      await _themeReapository.setThemeMode(event.themeMode);
      emit(ThemeState.loaded(event.themeMode));
    });
  }
}
