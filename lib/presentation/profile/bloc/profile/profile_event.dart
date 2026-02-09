part of'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileLoadRequest extends ProfileEvent {

  ProfileLoadRequest();

  @override
  List<Object?> get props => [];
}

class ProfileUpdate extends ProfileEvent{

  final String slug;
  final Map<String,dynamic> data;

   ProfileUpdate({required this.slug,required this.data});

  @override
  List<Object?> get props => [slug,data];
}

class ProfileAvatarUpdate extends ProfileEvent{

  final int? avatarId;

  ProfileAvatarUpdate({required this.avatarId});

  @override
  List<Object?> get props => [avatarId];
}

class ProfileDeleteRequest extends ProfileEvent {}
