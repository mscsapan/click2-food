import '../../../data/models/auth/user_response_model.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '/presentation/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/auth/auth_state_model.dart';
import '../../repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStateModel> {
  final AuthRepository _repository;

  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(const AuthStateModel()) {
    on<AuthEventUserEmail>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<AuthEventPassword>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<AuthShowPassword>((event, emit) {
      emit(state.copyWith(isActive: !state.isActive));
    });
    on<AuthEmailValidate>(_emailValidate);
    on<AuthPasswordValidate>(_passwordValidate);
    on<AuthEventLogin>(_login);
  }

  void _emailValidate(AuthEmailValidate event, Emitter<AuthStateModel> emit) {
    final trimmedEmail = state.email.trim();

    if (trimmedEmail.isEmpty) {
      emit(state.copyWith(authState: const AuthInvalidEmail('Email is required')));
    } else if (!Utils.isValidEmail(trimmedEmail)) {
      emit(state.copyWith(authState: const AuthInvalidEmail('Invalid email')));
    } else {
      emit(state.copyWith(authState: const AuthInitial()));
    }
  }

  void _passwordValidate(AuthPasswordValidate event, Emitter<AuthStateModel> emit) {
    final trimmedPass = state.password.trim();

    if (trimmedPass.isEmpty) {
      emit(state.copyWith(authState: const AuthInvalidPassword('Password is required')));
    } else if (!Utils.isValidPassword(trimmedPass)) {
      emit(state.copyWith(authState: const AuthInvalidPassword('*Please enter a valid password')));
    } else {
      emit(state.copyWith(authState: const AuthInitial()));
    }
  }

  Future<void> _login(AuthEventLogin event, Emitter<AuthStateModel> emit) async {
    emit(state.copyWith(authState: AuthStateLoading()));
    final result = await _repository.login(state);
    result.fold(
          (failure) {
        if (failure is InvalidAuthData) {
          final errors = AuthStateFormValidate(failure.errors);
          emit(state.copyWith(authState: errors));
        } else {
          final errors = AuthStateError(failure.message,failure.statusCode);
          emit(state.copyWith(authState: errors));
        }
      },
          (success) {
        final userLoaded = AuthStateLoaded(responses: success);

        emit(state.copyWith(authState: userLoaded));
      },
    );
  }
}
