import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'update_profile_event.dart';

part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final MetaClubApiClient metaClubApiClient;
  Profile? updateProfile;

  UpdateProfileBloc({required this.metaClubApiClient})
      : super(const UpdateProfileState(status: NetworkStatus.initial)) {
    on<ProfileUpdate>(_onProfileUpdateRequest);
    on<OnDepartmentUpdate>(_onDepartmentUpdate);
    on<OnJoiningDateUpdate>(_onDateUpdate);
    on<OnGenderUpdate>(_onGenderUpdate);
    on<OnBloodUpdate>(_onBloodUpdate);
  }

  _onProfileUpdateRequest(ProfileUpdate event, Emitter<UpdateProfileState> emit) async {
    emit(const UpdateProfileState(status: NetworkStatus.loading));
    final success = await metaClubApiClient.updateProfile(slag: event.slug, data: event.data);
    success.fold((l) {
      emit(const UpdateProfileState(status: NetworkStatus.failure));
    }, (r) {
      if (r) {
        emit(const UpdateProfileState(status: NetworkStatus.success));
      } else {
        emit(const UpdateProfileState(status: NetworkStatus.failure));
      }
    });
  }

  void _onDateUpdate(OnJoiningDateUpdate event, Emitter<UpdateProfileState> emit) {
    emit(state.copyWith(dateTime: event.date));
  }

  void _onGenderUpdate(OnGenderUpdate event, Emitter<UpdateProfileState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onBloodUpdate(OnBloodUpdate event, Emitter<UpdateProfileState> emit) {
    emit(state.copyWith(bloodGroup: event.bloodGroup));
  }

  void _onDepartmentUpdate(OnDepartmentUpdate event, Emitter<UpdateProfileState> emit) {
    emit(state.copyWith(department: event.department));
  }
}
