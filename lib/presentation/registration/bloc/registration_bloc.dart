import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final MetaClubApiClient metaClubApiClient;

  RegistrationBloc({required this.metaClubApiClient})
      : super(const RegistrationState(items: [], selectedItems: [], status: NetworkStatus.initial)) {
    on<RegistrationInitialRequest>(_onRegistrationDataRequest);
    on<SelectedItemEvent>(_onSelectedItemEvent);
    on<SubmitButton>(_onSubmitButton);
    on<OnCountryChanged>(_onCountryChanged);
  }

  void _onCountryChanged(OnCountryChanged event, Emitter<RegistrationState> emit) async {
    final country = event.selectedCountry;

    if (kDebugMode) {
      print('_onCountryChanged Country $country');
    }

    emit(state.copyWith(selectedCountry: country));
  }

  void _onSubmitButton(SubmitButton event, Emitter<RegistrationState> emit) async {
    debugPrint("Button Click : ${event.items.toJson()}");
    emit(state.copyWith(status: NetworkStatus.loading));
    final data = await metaClubApiClient.registration(bodyData: event.items.toJson());
    data.fold((l) {
      emit(state.copyWith(status: NetworkStatus.errorDialog, message: 'Something went wrong, Try again later'));
    }, (r) {
      if (r.result != null) {
        emit(state.copyWith(
            status: r.result! ? NetworkStatus.successDialog : NetworkStatus.errorDialog,
            message: r.error ?? 'Registration now on pending'));
      } else {
        emit(state.copyWith(status: NetworkStatus.errorDialog, message: 'Something went wrong, Try again later'));
      }
    });
  }

  void _onSelectedItemEvent(SelectedItemEvent event, Emitter<RegistrationState> emit) {
    final List<Qualification> items = [];

    items.addAll(event.items);

    emit(RegistrationState(items: state.items, selectedItems: items, status: NetworkStatus.success));
  }

  void _onRegistrationDataRequest(
    RegistrationInitialRequest event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(const RegistrationState(status: NetworkStatus.loading, items: [], selectedItems: []));
    final qualifications = await metaClubApiClient.getQualification();
    qualifications.fold((l) {
      emit(const RegistrationState(status: NetworkStatus.failure, items: [], selectedItems: []));
    }, (r) {
      if (r != null) {
        final items = r.data.map((item) => Datum(name: item.name, id: item.id)).toList();
        emit(RegistrationState(status: NetworkStatus.success, items: items, selectedItems: const []));
      } else {
        emit(const RegistrationState(status: NetworkStatus.failure, items: [], selectedItems: []));
      }
    });
  }
}
