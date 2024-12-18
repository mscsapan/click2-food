part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  const OtpState();
  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpState {
 const OtpInitial();
}

class OtpStateOtpSending extends OtpState {}

class OtpStateOTPSent extends OtpState {
  final String responses;

  const OtpStateOTPSent({required this.responses});

  @override
  List<Object> get props => [responses];
}

class OtpStateError extends OtpState {
  final String message;
  final int statusCode;

  const OtpStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class OtpStateFormValidate extends OtpState {
  final Errors errors;

  const OtpStateFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}

