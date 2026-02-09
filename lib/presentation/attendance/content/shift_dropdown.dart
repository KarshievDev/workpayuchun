import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class ShiftDropdown extends StatelessWidget {
  final List<MultiShift> shifts;
  final MultiShift? selectedShift;
  final Function(MultiShift?) onShiftSelected;

  const ShiftDropdown({super.key, this.selectedShift, required this.shifts, required this.onShiftSelected});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: shifts.isNotEmpty,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<MultiShift>(
            isExpanded: true,
            value: selectedShift,
            icon: const Icon(
              Icons.arrow_downward,
              size: 20,
            ),
            iconSize: 24,
            elevation: 16,
            onChanged: onShiftSelected,
            items: shifts.map<DropdownMenuItem<MultiShift>>((MultiShift value) {
              return DropdownMenuItem<MultiShift>(
                value: value,
                child: Text(
                  value.shiftName ?? ''.tr(),
                  style: TextStyle(fontSize: 14.r),
                ).tr(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
