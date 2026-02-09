import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final MetaClubApiClient metaClubApiClient;

  ProfileBloc({required this.metaClubApiClient}) : super(const ProfileState(status: NetworkStatus.initial)) {
    on<ProfileLoadRequest>(_onProfileDataRequest);
    on<ProfileDeleteRequest>(_onAuthenticationDeleteRequest);
    on<ProfileUpdate>(_onProfileUpdateRequest);
    on<ProfileAvatarUpdate>(_onAvatarUpdate);
  }

  void _onProfileDataRequest(
    ProfileLoadRequest event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState(status: NetworkStatus.loading));
    final profile = await metaClubApiClient.getProfile();
    profile.fold((l) {
      emit(const ProfileState(status: NetworkStatus.failure));
    }, (r) {
      emit(ProfileState(status: NetworkStatus.success, profile: r));
    });
  }

  _onProfileUpdateRequest(ProfileUpdate event, Emitter<ProfileState> emit) async {
    emit(const ProfileState(status: NetworkStatus.loading));
    final success = await metaClubApiClient.updateProfile(slag: event.slug, data: event.data);
    success.fold((l) {
      emit(const ProfileState(status: NetworkStatus.failure));
    }, (r) {
      if (r) {
        add(ProfileLoadRequest());
      } else {
        emit(const ProfileState(status: NetworkStatus.failure));
      }
    });
  }

  _onAuthenticationDeleteRequest(ProfileDeleteRequest event, Emitter<ProfileState> emit) async {
    // final isDeleted = await metaClubApiClient.deleteAccount();
  }

  _onAvatarUpdate(ProfileAvatarUpdate event, Emitter<ProfileState> emit) async {
    if (event.avatarId != null) {
      await metaClubApiClient.updateProfileAvatar(avatarId: event.avatarId!);
      emit(ProfileState(status: NetworkStatus.success, profile: state.profile));
    }
  }
}
