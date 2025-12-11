import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/datasources/local/local_data_source.dart';

// Events
abstract class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleTheme extends ThemeEvent {}

class SetTheme extends ThemeEvent {
  final ThemeMode themeMode;
  SetTheme(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

// States
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({this.themeMode = ThemeMode.light});

  @override
  List<Object?> get props => [themeMode];
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final LocalDataSource localDataSource;

  ThemeBloc({required this.localDataSource}) : super(const ThemeState()) {
    on<ToggleTheme>(_onToggleTheme);
    on<SetTheme>(_onSetTheme);
    _loadTheme();
  }

  void _loadTheme() {
    final savedTheme = localDataSource.getThemeMode();
    if (savedTheme != null) {
      add(SetTheme(
        savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light,
      ));
    }
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    final newTheme =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeState(themeMode: newTheme));
    await localDataSource.saveThemeMode(
      newTheme == ThemeMode.dark ? 'dark' : 'light',
    );
  }

  Future<void> _onSetTheme(
    SetTheme event,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeState(themeMode: event.themeMode));
    await localDataSource.saveThemeMode(
      event.themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}
