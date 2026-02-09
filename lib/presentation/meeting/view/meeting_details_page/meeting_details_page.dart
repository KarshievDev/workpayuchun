import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../content/meeting_details_items.dart';

class MeetingDetailsPage extends StatelessWidget {
  final MeetingsItem? data;

  const MeetingDetailsPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("meeting_details").tr()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MeetingDetailsItems(
                title: 'title'.tr(), subTitle: data?.title ?? ''),
            MeetingDetailsItems(
                title: 'description'.tr(), subTitle: data?.title ?? ''),
            MeetingDetailsItems(title: 'date'.tr(), subTitle: data?.date ?? ''),
            MeetingDetailsItems(title: 'time'.tr(), subTitle: data?.time ?? ''),
            MeetingDetailsItems(
                title: 'location'.tr(), subTitle: data?.location ?? ''),
            MeetingDetailsItems(title: 'day'.tr(), subTitle: data?.day ?? ''),
            MeetingDetailsItems(
                title: 'start_time'.tr(), subTitle: data?.startAt ?? ''),
            MeetingDetailsItems(
                title: 'end_time'.tr(), subTitle: data?.endAt ?? '')
          ],
        ),
      ),
    );
  }
}
