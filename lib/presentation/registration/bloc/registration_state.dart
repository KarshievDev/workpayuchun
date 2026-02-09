part of "registration_bloc.dart";


class RegistrationState extends Equatable{
  final List<Datum> items;
  final List<Qualification> selectedItems;
  final NetworkStatus status;
  final String? message;
  final String selectedCountry;

  const RegistrationState({required this.items, this.status = NetworkStatus.initial,required this.selectedItems,this.message, this.selectedCountry = '+880'});

  RegistrationState copyWith({List<Datum>? items, NetworkStatus? status,String? message,String? selectedCountry}) {
    return RegistrationState(
        items: items ?? this.items,
        selectedItems: selectedItems,
        message: message ?? '',
        selectedCountry: selectedCountry ?? this.selectedCountry,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [items, status,selectedItems];
}
