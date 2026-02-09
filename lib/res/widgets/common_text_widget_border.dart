import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextFiledWithTitleBorder extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? title;
  final String? labelText;
  const CommonTextFiledWithTitleBorder({super.key, this.title, this.onChanged, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(title ?? '', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.r),),
        ),
        TextFormField(
          maxLines: 1,
          onChanged: onChanged,
          controller: controller,
          style: TextStyle(fontSize: 12.r),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: labelText ?? '',
            hintStyle: TextStyle(fontSize: 14.r),
            labelStyle: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return tr("this_field_is_required");
            }
            return null;
          },
        )
      ],
    );
  }
}
