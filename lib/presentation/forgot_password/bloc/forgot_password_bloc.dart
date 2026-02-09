import 'dart:async';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/forgot_password/content/change_password.dart';
import 'package:strawberryhrm/presentation/login/login.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

part 'forgot_password_state.dart';

part 'forgot_password_event.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final MetaClubApiClient metaClubApiClient;

  ForgotPasswordBloc({required this.metaClubApiClient})
      : super(const ForgotPasswordState(status: NetworkStatus.initial)) {
    on<GetVerificationCode>(_onVerificationCode);
    on<ForgotPassword>(_onForgotPassword);
  }

  FutureOr<void> _onVerificationCode(GetVerificationCode event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final data = await metaClubApiClient.getVerificationCode(email: event.email);
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      if (r.result == true) {
        Fluttertoast.showToast(msg: r.message.toString());
        if (event.context.mounted) {
          NavUtil.navigateScreen(
              event.context,
              BlocProvider.value(
                value: event.context.read<ForgotPasswordBloc>(),
                child: ChangePassword(
                  email: event.email,
                ),
              ));
        }
        emit(state.copyWith(status: NetworkStatus.success));
        if (kDebugMode) {
          print('success');
        }
      } else {
        Fluttertoast.showToast(msg: r.message.toString());
        emit(state.copyWith(status: NetworkStatus.failure));
      }
    });
  }

  FutureOr<void> _onForgotPassword(ForgotPassword event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final data = await metaClubApiClient.forgetPassword(forgotPasswordBody: event.forgotPasswordBody);
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      if (r.result == true) {
        Fluttertoast.showToast(msg: r.message.toString());
        if (event.context.mounted) {
          NavUtil.navigateScreen(event.context, const LoginPage());
        }
        emit(state.copyWith(status: NetworkStatus.success));
      } else {
        Fluttertoast.showToast(msg: r.message.toString());
        emit(state.copyWith(status: NetworkStatus.failure));
      }
    });
  }
}
