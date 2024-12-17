part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthEventUserEmail extends AuthEvent {
  final String email;

  const AuthEventUserEmail(this.email);

  @override
  List<Object> get props => [email];
}

class AuthEventPassword extends AuthEvent {
  final String password;

  const AuthEventPassword(this.password);

  @override
  List<Object> get props => [password];
}
class AuthShowPassword extends AuthEvent {
  const AuthShowPassword();
}

class AuthEmailValidate extends AuthEvent {
  const AuthEmailValidate();
}

class AuthPasswordValidate extends AuthEvent {
  const AuthPasswordValidate();
}

class AuthEventLogin extends AuthEvent {
  const AuthEventLogin();
}