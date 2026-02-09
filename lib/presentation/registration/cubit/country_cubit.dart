import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryCubit extends Cubit<CountryState>{

  CountryCubit() : super(CountryState());

  void onCountryChanged({required Country country}){
    return emit(CountryState(selectedCountry: country));
  }
}

class CountryState{
  final Country? selectedCountry;
  CountryState({this.selectedCountry});
}