import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../../logic/bloc/otp/otp_bloc.dart';

class AuthStateModel extends Equatable {
  final String name;
  final String email;
  final String password;
  final String conPassword;
  final String otp;
  final bool isActive;
  final bool show;
  final bool showCon;
  final AuthState authState;
  final OtpState otpState;

  const AuthStateModel({
    this.name = '',
    this.email = '',
    this.password = '',
    this.conPassword = '',
    this.otp = '',
    this.isActive = true,
    this.show = true,
    this.showCon = true,
    this.authState = const AuthInitial(),
    this.otpState = const OtpInitial(),
  });

  AuthStateModel copyWith({
    String? email,
    String? password,
    String? name,
    String? conPassword,
    String? otp,
    bool? isActive,
    bool? show,
    bool? showCon,
    AuthState? authState,
    OtpState? otpState,
  }) {
    return AuthStateModel(
      email: email ?? this.email,
      password: password ?? this.password,
      otp: otp ?? this.otp,
      isActive: isActive ?? this.isActive,
      show: show ?? this.show,
      name: name ?? this.name,
      conPassword: conPassword ?? this.conPassword,
      showCon: showCon ?? this.showCon,
      authState: authState ?? this.authState,
      otpState: otpState ?? this.otpState,
    );
  }

  AuthStateModel clear() {
    return const AuthStateModel(
      email: '',
      password: '',
      name: '',
      conPassword: '',
      showCon: true,
      otp: '',
      isActive: true,
      show: true,
      authState: AuthInitial(),
      otpState: OtpInitial(),
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userName': email});
    result.addAll({'password': password});
    result.addAll({'rememberMe': true});
    return result;
  }

  Map<String, dynamic> toAddMap() {
    final result = <String, dynamic>{};

    result.addAll({'userName': name});
    result.addAll({'email': email});
    result.addAll({'password': password});
    return result;
  }

  factory AuthStateModel.fromMap(Map<String, dynamic> map) {
    return AuthStateModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthStateModel.fromJson(String source) =>
      AuthStateModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginModelState(username: $email, password: $password, state: $authState)';

  @override
  List<Object> get props => [
        email,
        password,
        otp,
        name,
        conPassword,
        showCon,
        isActive,
        show,
        authState,
        otpState
      ];
}
