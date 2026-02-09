import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class CustomDocumentTypeDropDown extends StatelessWidget {
  final List<DocumentType> items;
  final DocumentType? item;
  final String title;
  final String? hint;
  final Function(DocumentType?) onChange;

  const CustomDocumentTypeDropDown(
      {super.key, required this.items, required this.title, required this.onChange, this.hint, this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
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
                BoxShadow(color: Colors.black12, spreadRadius: 1),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<DocumentType>(
                isExpanded: true,
                hint: Text(
                  hint ?? "",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                value: item,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 23.0,
                  color: Colors.black,
                ),
                iconSize: 24,
                elevation: 16,
                onChanged: onChange,
                items: items.map<DropdownMenuItem<DocumentType>>((DocumentType value) {
                  return DropdownMenuItem<DocumentType>(
                    value: value,
                    child: Text(
                      '${value.name}',
                      style: TextStyle(fontSize: 14.r),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTravelModesTypeDropDown extends StatelessWidget {
  final List<String> items;
  final String? item;
  final String title;
  final String? hint;
  final Function(String?) onChange;

  const CustomTravelModesTypeDropDown(
      {super.key, required this.items, required this.title, required this.onChange, this.hint, this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
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
                BoxShadow(color: Colors.black12, spreadRadius: 1),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  hint ?? "",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                value: item ?? items.first,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 23.0,
                  color: Colors.black,
                ),
                iconSize: 24,
                elevation: 16,
                onChanged: onChange,
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
      ),
    );
  }
}

class SimpleDropDown extends StatelessWidget {
  final List<String> items;
  final String title;
  final String? initialData;
  final Function(String?) onChanged;

  const SimpleDropDown(
      {super.key, required this.items, required this.title, required this.onChanged, required this.initialData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
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
