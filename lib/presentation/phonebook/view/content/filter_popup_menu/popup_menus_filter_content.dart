import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/phonebook/view/content/filter_popup_menu/filter_bottom_sheet_list.dart';

enum PhonebookFilterType { designation, department }

class PopupMenusFilerContent extends StatelessWidget {
  final Bloc? bloc;
  final Settings? settings;

  const PopupMenusFilerContent({super.key, this.bloc, required this.settings});

  @override
  Widget build(BuildContext context) {
    PhonebookFilterType? selectedMenu;
    return Container(
      margin: const EdgeInsets.only(right: 12.0).r,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
      child: PopupMenuButton<PhonebookFilterType>(
        icon: Icon(
          Icons.drag_indicator_sharp,
          size: 20.r,
        ),
        initialValue: selectedMenu,
        onSelected: (PhonebookFilterType item) {
          _onChoiceSelectedModelSheet(context, item, bloc, settings);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<PhonebookFilterType>>[
          PopupMenuItem<PhonebookFilterType>(
            value: PhonebookFilterType.department,
            child: Text(
              'department',
              style: TextStyle(fontSize: 12.r),
            ).tr(),
          ),
          PopupMenuItem<PhonebookFilterType>(
            value: PhonebookFilterType.designation,
            child: Text('designation', style: TextStyle(fontSize: 12.r)).tr(),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _onChoiceSelectedModelSheet(context, PhonebookFilterType item, Bloc? bloc, Settings? settings) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.2,
        maxChildSize: 0.85,
        expand: false,
        builder: (_, controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                height: 4,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[600],
                ),
              ),
            ),
            ListTile(
              title: Text(
                item.name.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12.r),
              ).tr(),
            ),
            Expanded(
              child: FilterBottomSheetList(
                bloc: bloc,
                controller: controller,
                type: item,
                settings: settings,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
