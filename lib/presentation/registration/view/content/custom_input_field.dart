import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final Function(String)? onChanged;
  final TextInputType textInputType;
  final String? hintText;
  final int maxLine;
  final bool isReadOnly;
  final EdgeInsets edgeInsets;

  const CustomInputField(
      {super.key,
      this.onChanged,
      this.textInputType = TextInputType.name,
      this.hintText,
      this.isReadOnly = false,
      this.maxLine = 1,
      this.edgeInsets = const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0)});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLine,
      style: const TextStyle(fontSize: 14),
      onChanged: onChanged,
      keyboardType: textInputType,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        contentPadding: edgeInsets,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 12),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
    );
  }
}
