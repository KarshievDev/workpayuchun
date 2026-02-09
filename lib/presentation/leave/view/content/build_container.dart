import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildContainer extends StatelessWidget {
  final String? title;
  final String? titleValue;
  final Function()? onPressed;
  final bool iconVisibility;

  const BuildContainer(
      {super.key,
      this.title,
      this.titleValue,
      this.onPressed,
      this.iconVisibility = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
              width: 130.w,
              child: Text(
                title ?? '',
                style: TextStyle(fontSize: 14.r),
              )),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    titleValue ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.r),
                    maxLines: 1,
                  ).tr(),
                ),
                Visibility(
                  visible: iconVisibility,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25.r),
                    onTap: onPressed,
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
