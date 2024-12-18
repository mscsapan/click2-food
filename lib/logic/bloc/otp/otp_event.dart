part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();
  @override
  List<Object?> get props => [];
}

class OtpEventSendOTP extends OtpEvent {
  const OtpEventSendOTP();
}

class OtpEventEmail extends OtpEvent {
  final String email;

  const OtpEventEmail(this.email);

  @override
  List<Object> get props => [email];
}