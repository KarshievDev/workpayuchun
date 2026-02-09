part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final Profile? profile;
  final NetworkStatus status;

  const ProfileState({this.profile, this.status = NetworkStatus.initial});

  ProfileState copyWith({Profile? profile, NetworkStatus? status}) {
    return ProfileState(
        profile: profile ?? this.profile, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [profile, status];
}
