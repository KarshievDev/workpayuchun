import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_radio_tile.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CustomRadioTile(
            onChanged: (genderValue) {
              if (kDebugMode) {
                print("Radio $genderValue");
              }
            },
            title: 'Yes',
            initialData: "Yes",
          ),
        ),
        Expanded(
          child: CustomRadioTile(
            onChanged: (genderValue) {
              if (kDebugMode) {
                print("Radio $genderValue");
              }
            },
            title: 'No',
            initialData: "",
          ),
        ),
        Expanded(
          child: CustomRadioTile(
            onChanged: (genderValue) {
              if (kDebugMode) {
                print("Radio $genderValue");
              }
            },
            title: 'Other',
            initialData: "",
          ),
        ),
      ],
    );
  }
}
