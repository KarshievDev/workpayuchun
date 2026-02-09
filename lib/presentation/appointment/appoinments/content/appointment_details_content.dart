import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final MeetingsItem? data;

  const AppointmentDetailsScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("appointment_details"),
          style: TextStyle(fontSize: 18.r),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildContainer(
                title: 'appointment_with'.tr(),
                titleValue: data?.appointmentWith ?? ''),
            buildContainer(
                title: tr("description"), titleValue: data?.title ?? ''),
            buildContainer(title: tr("date"), titleValue: data?.date ?? ''),
            buildContainer(title: tr("time"), titleValue: data?.time ?? ''),
            buildContainer(
                title: tr("location"), titleValue: data?.location ?? ''),
            buildContainer(title: tr("day"), titleValue: data?.day ?? ''),
            buildContainer(
                title: tr("start_time"), titleValue: data?.startAt ?? ''),
            buildContainer(
                title: tr("end_time"), titleValue: data?.endAt ?? ''),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: Text(
                  data?.appointmentWith ?? '',
                  style: TextStyle(fontSize: 12.r),
                ),
                children: [
                  buildContainer(
                      title: tr("agree"),
                      titleValue: data?.participants?[0].isAgree ?? ''),
                  buildContainer(
                      title: tr("present"),
                      titleValue: data?.participants?[0].isPresent ?? ''),
                  buildContainer(
                      title: tr("present_at"),
                      titleValue: data?.participants?[0].presentAt ?? ''),
                  buildContainer(
                      title: tr("appointment_start_at"),
                      titleValue:
                          data?.participants?[0].appointmentStartedAt ?? ''),
                  buildContainer(
                      title: tr("appointment_end_at"),
                      titleValue:
                          data?.participants?[0].appointmentEndedAt ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer(
      {String? title,
      String? titleValue,
      Function()? onPressed,
      bool iconVisibility = false}) {
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
              width: 130,
              child: Text(
                title ?? '',
                style: TextStyle(fontSize: 12.r),
              )),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    titleValue ?? '',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 12.r),
                    maxLines: 1,
                  ),
                ),
                Visibility(
                  visible: iconVisibility,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
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
