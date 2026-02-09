import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'support_event.dart';

part 'support_state.dart';

var dateTime = DateTime.now();

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  final MetaClubApiClient _metaClubApiClient;

  SupportBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const SupportState(status: NetworkStatus.initial)) {
    on<GetSupportData>(_onSupportLoad);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<OnFilterUpdate>(_onFilterChange);
    on<GetPriority>(_onGetPriority);
    on<SubmitButton>(_onSubmitButton);
  }

  FutureOr<void> _onSupportLoad(GetSupportData event, Emitter<SupportState> emit) async {
    final currentDate = DateFormat('y-MM').format(DateTime.now());

    emit(state.copy(status: NetworkStatus.loading, filter: event.filter, currentMonth: event.date));

    final success =
        await _metaClubApiClient.getSupport(getSelectedIndex(filter: state.filter), state.currentMonth ?? currentDate);
    success.fold((l) {
      emit(state.copy(status: NetworkStatus.failure, filter: event.filter, currentMonth: event.date));
    }, (r) {
      if (r != null) {
        emit(state.copy(
            status: NetworkStatus.success, supportListModel: r, filter: event.filter, currentMonth: event.date));
      } else {
        emit(state.copy(status: NetworkStatus.failure, filter: event.filter, currentMonth: event.date));
      }
    });
  }

  String getSelectedIndex({required Filter filter}) {
    late String selectedIndex;
    switch (state.filter) {
      case Filter.open:
        selectedIndex = '12';
        break;
      case Filter.close:
        selectedIndex = '13';
        break;
      case Filter.all:
        selectedIndex = '';
        break;
      }
    return selectedIndex;
  }

  FutureOr<void> _onSelectDatePicker(SelectDatePicker event, Emitter<SupportState> emit) async {
    var date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      // initialDate: date == null ? DateTime.now() :date! ,
      initialDate: dateTime,
      locale: const Locale("en"),
    );
    if (date != null) {
      dateTime = date;
      String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
      add(GetSupportData(filter: state.filter, date: currentMonth));
    }
  }

  FutureOr<void> _onFilterChange(OnFilterUpdate event, Emitter<SupportState> emit) {
    emit(state.copy(filter: event.filter));

    add(GetSupportData(filter: event.filter, date: event.date));
  }

  FutureOr<void> _onGetPriority(GetPriority event, Emitter<SupportState> emit) {
    emit(state.copy(bodyPrioritySupport: event.bodyPrioritySupport));
  }

  FutureOr<void> _onSubmitButton(SubmitButton event, Emitter<SupportState> emit) async {
    emit(state.copy(status: NetworkStatus.loading));
    if (event.bodyCreateSupport.priorityId == null) {
      Fluttertoast.showToast(msg: "You must set priority".tr());
    } else if (event.bodyCreateSupport.subject == null) {
      Fluttertoast.showToast(msg: "Subject filed can not be empty".tr());
    } else {
      await _metaClubApiClient.createSupport(bodyCreateSupport: event.bodyCreateSupport).then((success) {
        success.fold((l) {
          emit(state.copy(status: NetworkStatus.failure));
        }, (r) {
          if (r) {
            add(GetSupportData(filter: event.filter, date: event.date));
            Fluttertoast.showToast(msg: "ticket_created_successfully".tr());
            if (event.context.mounted) {
              Navigator.pop(event.context);
            }
          } else {
            emit(state.copy(status: NetworkStatus.failure));
          }
        });
      });
    }
  }
}
