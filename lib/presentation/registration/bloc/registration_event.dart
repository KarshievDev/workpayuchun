part of "registration_bloc.dart";

abstract class RegistrationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegistrationInitialRequest extends RegistrationEvent {}

class RegistrationSuccessEvent extends RegistrationEvent {}

class SelectedItemEvent extends RegistrationEvent{
  final List<Qualification> items;
  final Datum? datum;
  SelectedItemEvent({required this.items,this.datum});
  @override
  List<Object?> get props => [items,datum];
}

class SubmitButton extends RegistrationEvent{
  final BodyRegistration items;
  SubmitButton({required this.items});
  @override
  List<Object?> get props => [items];
}

class OnCountryChanged extends RegistrationEvent{
  final String selectedCountry;
  OnCountryChanged({required this.selectedCountry});
  @override
  List<Object?> get props => [selectedCountry];
}


