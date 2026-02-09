part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSettings extends HomeEvent {}

class LoadHomeData extends HomeEvent {}

class OnHomeRefresh extends HomeEvent {}

class OnLocationRefresh extends HomeEvent {
  final User? user;

  OnLocationRefresh({required this.user});
}

class OnSwitchPressed extends HomeEvent {
  final User? user;

  OnSwitchPressed({required this.user});
}

class OnTokenVerification extends HomeEvent {}

class OnLocationEnabled extends HomeEvent {
  final User user;

  OnLocationEnabled({required this.user});
}

class OnResetEvent extends HomeEvent {}
