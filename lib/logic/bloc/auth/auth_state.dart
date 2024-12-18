part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();

}

final class AuthInvalidEmail extends AuthState {
  final String message;
  const AuthInvalidEmail(this.message);
  @override
  List<Object> get props => [message];

}

final class AuthInvalidPassword extends AuthState {
  final String message;
  const AuthInvalidPassword(this.message);
  @override
  List<Object> get props => [message];

}

final class AuthInvalidConPassword extends AuthState {
  final String message;
  const AuthInvalidConPassword(this.message);
  @override
  List<Object> get props => [message];

}


class AuthStateLoading extends AuthState {}

// class AuthStateLogoutLoading extends AuthState {
//   @override
//   List<Object> get props => [];
// }

class AuthStateError extends AuthState {
  final String message;
  final int statusCode;

  const AuthStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class AuthStateLoaded extends AuthState {
  final UserResponse responses;

  const AuthStateLoaded({required this.responses});

  @override
  List<Object> get props => [responses];
}

class AuthStateUserAdded extends AuthState {
  final String responses;

  const AuthStateUserAdded({required this.responses});

  @override
  List<Object> get props => [responses];
}

class AuthStateFormValidate extends AuthState {
  final Errors errors;

  const AuthStateFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}

class AuthStateExistUser extends AuthState {
  final bool responses;

  const AuthStateExistUser({required this.responses});

  @override
  List<Object> get props => [responses];
}

class AuthStateOTPVerify extends AuthState {
  final String responses;

  const AuthStateOTPVerify({required this.responses});

  @override
  List<Object> get props => [responses];
}