import 'dart:async';
import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:user_repository/user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../models/password.dart';
import '../models/email.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  final LoginWithEmailPasswordUseCase loginWIthEmailPasswordUseCase;
  final GetDeviceIdUseCase _getDeviceIdUseCase;
  final GetDeviceNameUseCase _getDeviceNameUseCase;
  final ChatService _chatService;
  final formKey = GlobalKey<FormState>();

  LoginBloc({
    required this.loginWIthEmailPasswordUseCase,
    required ChatService chatService,
    required GetDeviceIdUseCase getDeviceIdUseCase,
    required GetDeviceNameUseCase getDeviceNameUseCase,
  }) : _chatService = chatService,
       _getDeviceIdUseCase = getDeviceIdUseCase,
       _getDeviceNameUseCase = getDeviceNameUseCase,
       super(const LoginState()) {
    on<LoginEmailChange>(_onEmailUpdate);
    on<LoginPasswordChange>(_onPasswordUpdate);
    on<LoginSubmit>(_onLoginSubmitted);
    on<OnObscureEvent>(_onObscureEvent);
  }

  void _onEmailUpdate(LoginEmailChange event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onPasswordUpdate(LoginPasswordChange event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onLoginSubmitted(LoginSubmit event, Emitter<LoginState> emit) async {
    final deviceId = await _getDeviceIdUseCase();
    final deviceName = await _getDeviceNameUseCase();

    if (state.isValid) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.inProgress,
          loginAction: LoginAction.login,
        ),
      );
      final eitherOrUser = await loginWIthEmailPasswordUseCase(
        email: state.email.value,
        password: state.password.value,
        deviceId: deviceId,
        deviceInfo: deviceName,
      );

      eitherOrUser.fold(
        (l) => emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            failure: l,
            loginAction: LoginAction.login,
          ),
        ),
        (r) {
          if (r?.user != null) {
            final cid = globalState.get(companyId);

            ///create/update user information into fireStore
            _chatService.createAndUpdateUserInfo(
              r?.user?.toJson(),
              '$cid${r?.user?.id}',
            );
            emit(
              state.copyWith(
                status: FormzSubmissionStatus.success,
                user: r,
                loginAction: LoginAction.login,
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: FormzSubmissionStatus.canceled,
                user: r,
                loginAction: LoginAction.login,
              ),
            );
          }
        },
      );
    }
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    if (data != null) {
      final userData = LoginData.fromJson(data);
      return LoginState(user: userData, status: FormzSubmissionStatus.success);
    } else {
      return const LoginState(
        user: null,
        status: FormzSubmissionStatus.failure,
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    return <String, dynamic>{'data': state.user?.toJson()};
  }

  FutureOr<void> _onObscureEvent(
    OnObscureEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        isObscure: !state.isObscure,
        loginAction: LoginAction.obscure,
      ),
    );
  }
}
