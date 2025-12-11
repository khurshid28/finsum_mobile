import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/datasources/local/local_data_source.dart';

// Events
abstract class LocaleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeLocale extends LocaleEvent {
  final Locale locale;
  ChangeLocale(this.locale);

  @override
  List<Object?> get props => [locale];
}

// States
class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState({this.locale = const Locale('uz', 'UZ')});

  @override
  List<Object?> get props => [locale];
}

// BLoC
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final LocalDataSource localDataSource;

  LocaleBloc({required this.localDataSource}) : super(const LocaleState()) {
    on<ChangeLocale>(_onChangeLocale);
    _loadLocale();
  }

  void _loadLocale() {
    final savedLocale = localDataSource.getLocale();
    if (savedLocale != null) {
      final parts = savedLocale.split('_');
      if (parts.length == 2) {
        add(ChangeLocale(Locale(parts[0], parts[1])));
      }
    }
  }

  Future<void> _onChangeLocale(
    ChangeLocale event,
    Emitter<LocaleState> emit,
  ) async {
    emit(LocaleState(locale: event.locale));
    await localDataSource.saveLocale(event.locale.toString());
  }
}
