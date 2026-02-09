import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/phonebook/phonebook.dart';
import 'package:strawberryhrm/res/common/debouncer.dart';

class PlutoPhoneBookSearch extends StatelessWidget {
  const PlutoPhoneBookSearch({super.key, this.bloc});
  final Bloc? bloc;

  @override
  Widget build(BuildContext context) {
    final deBouncer = Debounce(milliseconds: 1000);
    return Padding(padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 10, bottom: 10.0).r,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(CupertinoIcons.search), hintText: "search".tr(),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Branding.colors.primaryLight),
              borderRadius: BorderRadius.all(Radius.circular(40.0.r),)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Branding.colors.primaryLight),
              borderRadius: BorderRadius.all(Radius.circular(40.0.r),)
          ),
          hintStyle: TextStyle(fontSize: 12.r,), filled: true, contentPadding:  EdgeInsets.all(0.r),

        ),
        onChanged: (value) {
          deBouncer.run(() => bloc?.add(PhoneBookSearchData(searchText: value.toString())));
        },
      ),
    );
  }
}
