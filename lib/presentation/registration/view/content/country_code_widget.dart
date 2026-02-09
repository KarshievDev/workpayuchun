import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/registration/view/content/registration_content.dart';
import '../../cubit/country_cubit.dart';
import 'custom_input_field.dart';

class CountryCodeView extends StatelessWidget {
  const CountryCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        bodyRegistration.phoneCode = '+880';

        return SizedBox(
          height: 55.0,
          child: Row(
            children: [
              SizedBox(
                width: 75.0,
                height: 48.0,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  ),
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        BlocProvider.of<CountryCubit>(context).onCountryChanged(country: country);
                        bodyRegistration.phoneCode = '+${state.selectedCountry?.phoneCode ?? '880'}';
                        debugPrint('Select country: ${bodyRegistration.phoneCode}');
                      },
                    );
                  },
                  child: Text(
                    '${state.selectedCountry?.flagEmoji ?? '🇧🇩'} +${state.selectedCountry?.phoneCode ?? '880'}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: CustomInputField(
                  onChanged: (value) {
                    bodyRegistration.phone = value;
                  },
                  hintText: "Phone number",
                  textInputType: TextInputType.phone,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
