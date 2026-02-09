import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_radio_tile.dart';
import '../../bloc/update/update_profile_bloc.dart';
import '../../model/update_official_data.dart';

class GenderRadioContent extends StatelessWidget {
  final BodyPersonalInfo personal;
  final Bloc bloc;
  final Function(BodyPersonalInfo) onPersonalUpdate;

  const GenderRadioContent({
    super.key,
    required this.personal,
    required this.bloc,
    required this.onPersonalUpdate,
  });

  @override
  Widget build(BuildContext context) {
    personal.gender ??= bloc.state.gender;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "gender*".tr(),
          style: TextStyle(
              color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomRadioTile(
                onChanged: (genderValue) {
                  if (kDebugMode) {
                    print("Radio $genderValue");
                  }
                  personal.gender = genderValue;
                  onPersonalUpdate(personal);
                  bloc.add(OnGenderUpdate(gender: personal.gender!));
                },
                title: 'male'.tr(),
                initialData: personal.gender,
              ),
            ),
            Expanded(
              child: CustomRadioTile(
                onChanged: (genderValue) {
                  if (kDebugMode) {
                    print("Radio $genderValue");
                  }
                  personal.gender = genderValue;
                  onPersonalUpdate(personal);
                  bloc.add(OnGenderUpdate(gender: personal.gender!));
                },
                title: 'female'.tr(),
                initialData: personal.gender,
              ),
            ),
            Expanded(
              child: CustomRadioTile(
                onChanged: (genderValue) {
                  if (kDebugMode) {
                    print("Radio $genderValue");
                  }
                  personal.gender = genderValue;
                  onPersonalUpdate(personal);
                  bloc.add(OnGenderUpdate(gender: personal.gender!));
                },
                title: 'unisex'.tr(),
                initialData: personal.gender,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
