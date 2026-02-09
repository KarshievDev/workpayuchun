import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/phonebook/phonebook.dart';
import 'package:strawberryhrm/res/common/debouncer.dart';

class PhoneBookSearch extends StatelessWidget {
  const PhoneBookSearch({super.key, this.bloc});
  final Bloc? bloc;

  @override
  Widget build(BuildContext context) {
    final deBouncer = Debounce(milliseconds: 1000);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0, bottom: 8.0).r,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "search".tr(),
          hintStyle: TextStyle(fontSize: 12.r),
          filled: true,
          fillColor: Branding.colors.container,
          contentPadding:  EdgeInsets.all(8.r),
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0.r),
            ),
          ),
        ),
        onChanged: (value) {
          deBouncer.run(() =>
              bloc?.add(PhoneBookSearchData(searchText: value.toString())));
        },
      ),
    );
  }
}
