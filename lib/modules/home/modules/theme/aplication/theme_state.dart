part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState._({
    this.status = ThemeStatus.unknown,
    this.themeMode = ThemeMode.system,
  });

  const ThemeState.unknown() : this._();
  const ThemeState.loading() : this._(status: ThemeStatus.loading);
  const ThemeState.loaded(ThemeMode mode)
      : this._(
          themeMode: mode,
          status: ThemeStatus.loaded,
        );

  final ThemeStatus status;

  final ThemeMode themeMode;
  @override
  List<Object?> get props => [status, themeMode];
}
