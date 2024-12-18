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

class AuthEventUserName extends AuthEvent {
  final String name;

  const AuthEventUserName(this.name);

  @override
  List<Object> get props => [name];
}

class AuthEventPassword extends AuthEvent {
  final String password;

  const AuthEventPassword(this.password);

  @override
  List<Object> get props => [password];
}

class AuthEventConPassword extends AuthEvent {
  final String conPassword;

  const AuthEventConPassword(this.conPassword);

  @override
  List<Object> get props => [conPassword];
}

class AuthShowPassword extends AuthEvent {
  const AuthShowPassword();
}

class AuthShowConPassword extends AuthEvent {
  const AuthShowConPassword();
}

class AuthAddOTP extends AuthEvent {
  final String otp;
  const AuthAddOTP(this.otp);
  @override
  List<Object?> get props => [otp];
}

class AuthEmailValidate extends AuthEvent {
  const AuthEmailValidate();
}

class AuthPasswordValidate extends AuthEvent {
  const AuthPasswordValidate();
}

class AuthConPasswordValidate extends AuthEvent {
  const AuthConPasswordValidate();
}

class AuthEventReset extends AuthEvent {
  const AuthEventReset();
}

class AuthEventLogin extends AuthEvent {
  const AuthEventLogin();
}

class AuthEventAddUser extends AuthEvent {
  const AuthEventAddUser();
}

class AuthEventCheckUser extends AuthEvent {
  const AuthEventCheckUser();
}

class AuthEventVerifyOtp extends AuthEvent {
  const AuthEventVerifyOtp();
}
