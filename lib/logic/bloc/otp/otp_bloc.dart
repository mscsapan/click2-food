import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/auth/auth_state_model.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../repository/auth_repository.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, AuthStateModel> {
  final AuthRepository _repository;

  OtpBloc({required AuthRepository repository})
      : _repository = repository,
        super(const AuthStateModel()) {

    on<OtpEventEmail>((event, emit) {emit(state.copyWith(email: event.email));});
    // on<AuthEmailValidate>(_emailValidate);
    // on<AuthPasswordValidate>(_passwordValidate);
    // on<AuthEventLogin>(_login);
    // on<AuthEventCheckUser>(_checkUser);
    on<OtpEventSendOTP>(_sendOtp);
    // on<AuthEventReset>(_reset);
  }

  Future<void> _sendOtp(OtpEventSendOTP event, Emitter<AuthStateModel> emit) async {
    emit(state.copyWith(otpState: OtpStateOtpSending()));
    final result = await _repository.sendOtp(state);
    result.fold(
          (failure) {
        if (failure is InvalidAuthData) {
          final errors = OtpStateFormValidate(failure.errors);
          emit(state.copyWith(otpState: errors));
        } else {
          final errors = OtpStateError(failure.message,failure.statusCode);
          emit(state.copyWith(otpState: errors));
        }
      },
          (success) {
        final otpSent = OtpStateOTPSent(responses: success);

        emit(state.copyWith(otpState: otpSent));
      },
    );
  }
}
