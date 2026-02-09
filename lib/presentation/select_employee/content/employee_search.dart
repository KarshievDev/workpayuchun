import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/phonebook/bloc/phonebook_bloc.dart';
import 'package:strawberryhrm/res/common/debouncer.dart';
class EmployeeSearch extends StatelessWidget {
  final Bloc? bloc;
  const EmployeeSearch({super.key, this.bloc});

  @override
  Widget build(BuildContext context) {
    final deBouncer = Debounce(milliseconds: 1000);

    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 8.0, top: 10, bottom: 10.0).r,
      child: TextField(
        decoration:  InputDecoration(
          prefixIcon: Icon(Icons.search,size: 18.r,),
          hintText: "Search",
          hintStyle: TextStyle(fontSize: 14.r),
          filled: true,
          contentPadding:  EdgeInsets.symmetric(vertical: 8.h),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
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
