part of'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class ProfileUpdate extends UpdateProfileEvent{

  final String slug;
  final Map<String,dynamic> data;

   ProfileUpdate({required this.slug,required this.data});

  @override
  List<Object?> get props => [slug,data];
}
class OnDepartmentUpdate extends UpdateProfileEvent{
  final Department? department;

  OnDepartmentUpdate({required this.department});

  @override
  List<Object?> get props => [department?.id];
}

class OnJoiningDateUpdate extends UpdateProfileEvent{

  final DateTime date;

  OnJoiningDateUpdate({required this.date});

  @override
  List<Object?> get props => [date];
}

class OnGenderUpdate extends UpdateProfileEvent{

  final String gender;

  OnGenderUpdate({required this.gender});

  @override
  List<Object?> get props => [gender];
}

class OnBloodUpdate extends UpdateProfileEvent{

  final String bloodGroup;

  OnBloodUpdate({required this.bloodGroup});

  @override
  List<Object?> get props => [bloodGroup];
}