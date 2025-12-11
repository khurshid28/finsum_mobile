import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/usecases/get_user_usecase.dart';

// Events
abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {}

// States
abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;

  UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase getUserUseCase;

  UserBloc({required this.getUserUseCase}) : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
  }

  Future<void> _onLoadUser(
    LoadUser event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final user = await getUserUseCase();
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(UserError('Failed to load user'));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
