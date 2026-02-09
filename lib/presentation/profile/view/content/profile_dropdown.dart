import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class ProfileDropDown extends StatelessWidget {
  final List<Department> items;
  final Department? item;
  final String title;
  final String? hide;
  final Function(Department?) onChange;

  const ProfileDropDown(
      {super.key,
      required this.items,
      required this.title,
      required this.onChange,
        this.hide,
      this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [BoxShadow(color: Colors.grey, spreadRadius: 1),],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Department>(
              isExpanded: true,
              hint: Text(title, style: TextStyle(fontSize: 12.r),),
              value: item,
              icon: const Icon(Icons.keyboard_arrow_down, size: 20,),
              iconSize: 24,
              elevation: 16,
              onChanged: onChange,
              items: items.map<DropdownMenuItem<Department>>((Department value) {
                return DropdownMenuItem<Department>(
                  value: value,
                  child: Text('${value.title}', style: TextStyle(fontSize: 14.r),),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class SimpleDropDown extends StatelessWidget {
  final List<String> items;
  final String title;
  final String? initialData;
  final Function(String?) onChanged;

  const SimpleDropDown(
      {super.key,
      required this.items,
      required this.title,
      required this.onChanged,
      required this.initialData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, spreadRadius: 1),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                title,
                style: const TextStyle(fontSize: 14),
              ),
              value: initialData ?? items.first,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
              ),
              iconSize: 24,
              elevation: 16,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 14.r),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
