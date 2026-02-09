import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/support/content/priority_type.dart';
import 'package:strawberryhrm/presentation/support/content/type_name_widget.dart';
import 'package:strawberryhrm/presentation/support/view/support_details/support_details.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:core/core.dart';

class SupportTicketItem extends StatelessWidget {
  final SupportModel supportModel;

  const SupportTicketItem({super.key, required this.supportModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavUtil.navigateScreen(
            context,
            SupportDetails(
              supportModel: supportModel,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                const Positioned.fill(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: colorPrimary,
                        size: 20,
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supportModel.subject ?? "",
                      style: TextStyle(
                          fontSize: 12.r,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ).tr(),
                    Row(
                      children: [
                        Text(
                          supportModel.date ?? "",
                          style: TextStyle(fontSize: 10.r),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TypeNameWidget(supportModel: supportModel),
                        const SizedBox(
                          width: 8,
                        ),
                        PriorityType(supportModel: supportModel),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
