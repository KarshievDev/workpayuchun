import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldWithValidation extends StatelessWidget {
  final String title;
  final String? hints;
  final String? value;
  final int? maxLine;
  final Function(String?)? onData;
  final String? Function(String?)? validator;
  final String? errorMsg;
  final double? sizedBoxHeight;
  final TextEditingController? controller;
  final TextInputType textInputType;

  const CustomTextFieldWithValidation(
      {super.key,
      required this.title,
      this.value,
      this.controller,
      this.onData,
      this.hints,
      this.validator,
      this.maxLine,
      this.errorMsg,
      this.sizedBoxHeight = 10.0,this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 13.r, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: sizedBoxHeight,
        ),
        TextFormField(
          controller: controller,
          maxLines: maxLine,
          style: TextStyle(fontSize: 14.r),
          keyboardType: textInputType,
          onChanged: onData,
          validator: validator,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
            hintText: hints,
            hintStyle: TextStyle(fontSize: 12.r,color: Colors.black38),
            errorStyle: TextStyle(fontSize: 12.r),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2)),
            border: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.blue), borderRadius: BorderRadius.all(Radius.circular(5.0)),),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black12), borderRadius: BorderRadius.all(Radius.circular(5.0)),),
          ),
        ),
      ],
    );
  }
}
