import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/verify_code_usecase.dart';
import '../../../domain/usecases/verify_passport_usecase.dart';

// Events
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String phone;
  LoginRequested(this.phone);

  @override
  List<Object?> get props => [phone];
}

class VerifyCodeRequested extends AuthEvent {
  final String phone;
  final String code;

  VerifyCodeRequested(this.phone, this.code);

  @override
  List<Object?> get props => [phone, code];
}

class VerifyPassportRequested extends AuthEvent {
  final String series;
  final String number;
  final String birthDate;

  VerifyPassportRequested({
    required this.series,
    required this.number,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [series, number, birthDate];
}

// States
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String message;
  LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class VerifyCodeSuccess extends AuthState {}

class VerifyCodeFailure extends AuthState {
  final String message;
  VerifyCodeFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class VerifyPassportSuccess extends AuthState {}

class VerifyPassportFailure extends AuthState {
  final String message;
  VerifyPassportFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;
  final VerifyPassportUseCase verifyPassportUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.verifyCodeUseCase,
    required this.verifyPassportUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<VerifyCodeRequested>(_onVerifyCodeRequested);
    on<VerifyPassportRequested>(_onVerifyPassportRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final success = await loginUseCase(event.phone);
      if (success) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('Failed to send code'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onVerifyCodeRequested(
    VerifyCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final success = await verifyCodeUseCase(event.phone, event.code);
      if (success) {
        emit(VerifyCodeSuccess());
      } else {
        emit(VerifyCodeFailure('Invalid code'));
      }
    } catch (e) {
      emit(VerifyCodeFailure(e.toString()));
    }
  }

  Future<void> _onVerifyPassportRequested(
    VerifyPassportRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final success = await verifyPassportUseCase(
        series: event.series,
        number: event.number,
        birthDate: event.birthDate,
      );
      if (success) {
        emit(VerifyPassportSuccess());
      } else {
        emit(VerifyPassportFailure('Verification failed'));
      }
    } catch (e) {
      emit(VerifyPassportFailure(e.toString()));
    }
  }
}
