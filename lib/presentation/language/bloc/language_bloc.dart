import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/res/shared_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<SelectLanguage>(_onSelectLanguage);
  }

  FutureOr<void> _onSelectLanguage(
      SelectLanguage event, Emitter<LanguageState> emit) async {
    switch (event.selectIndex) {
      case 0:
        event.context.setLocale(const Locale('en', 'US'));
        break;
      case 1:
        event.context.setLocale(const Locale('bn', 'BN'));
        break;
      case 2:
        event.context.setLocale(const Locale('ar', 'AR'));
        break;
    }
    await SharedUtil.setLanguageIntValue(keySelectLanguage, event.selectIndex);
    emit(state.copy(selectedIndex: event.selectIndex));
  }
}
