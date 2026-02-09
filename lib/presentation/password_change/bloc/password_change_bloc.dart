import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';

part 'password_change_event.dart';

part 'password_change_state.dart';

class PasswordChangeBloc extends Bloc<PasswordChangeEvent, PasswordChangeState> {
  final MetaClubApiClient metaClubApiClient;

  PasswordChangeBloc({required this.metaClubApiClient})
      : super(const PasswordChangeState(status: NetworkStatus.initial)) {
    on<PasswordChange>(_onForgotPassword);
  }

  FutureOr<void> _onForgotPassword(PasswordChange event, Emitter<PasswordChangeState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final response = await metaClubApiClient.updatePassword(passwordChangeBody: event.passwordChangeBody);
    response.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      if (r.result == true) {
        Fluttertoast.showToast(msg: r.message.toString());
        if (event.context.mounted) {
          BlocProvider.of<AuthenticationBloc>(event.context).add(AuthenticationLogoutRequest());
          Navigator.of(event.context).pop();
        }
        emit(state.copyWith(status: NetworkStatus.success));
      } else {
        Fluttertoast.showToast(msg: r.message.toString());
        emit(state.copyWith(status: NetworkStatus.failure));
      }
    });
  }
}
