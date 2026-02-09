import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/phonebook/bloc/phonebook_bloc.dart';
import 'package:strawberryhrm/presentation/phonebook/view/content/filter_popup_menu/popup_menus_filter_content.dart';

class FilterBottomSheetList extends StatefulWidget {
  const FilterBottomSheetList({
    super.key,
    required this.controller,
    required this.type,
    required this.settings,
    this.bloc,
  });

  final Bloc? bloc;
  final ScrollController controller;
  final PhonebookFilterType type;
  final Settings? settings;

  @override
  State<FilterBottomSheetList> createState() => _FilterBottomSheetListState();
}

class _FilterBottomSheetListState extends State<FilterBottomSheetList> {
  @override
  Widget build(BuildContext context) {
    return widget.type.name == PhonebookFilterType.department.name
        ? buildDepartmentList(widget.bloc)
        : buildDesignationList(widget.bloc);
  }

  ListView buildDesignationList(Bloc? bloc) {
    return ListView.builder(
      controller: widget.controller,
      itemCount: widget.settings?.data?.designations.length ?? 0,
      itemBuilder: (context, index) {
        final data = widget.settings?.data?.designations[index];
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          tileColor: index % 2 == 0 ? Colors.grey.shade200 : Colors.grey.shade100,
          onTap: () {
            bloc?.add(SelectDesignationValue(data!));
            Navigator.pop(context);
          },
          title: Text(
            data?.title ?? '',
            style: TextStyle(fontSize: 12.r),
          ),
        );
      },
    );
  }

  ListView buildDepartmentList(Bloc? bloc) {
    return ListView.builder(
      controller: widget.controller,
      itemCount: widget.settings?.data?.departments.length ?? 0,
      itemBuilder: (context, index) {
        final data = widget.settings?.data?.departments[index];
        return ListTile(
          tileColor: index % 2 == 0 ? Colors.grey.shade200 : Colors.grey.shade100,
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          onTap: () {
            bloc?.add(SelectDepartmentValue(data!));
            Navigator.pop(context);
          },
          title: Text(
            data?.title ?? '',
            style: TextStyle(fontSize: 12.r),
          ),
        );
      },
    );
  }
}
