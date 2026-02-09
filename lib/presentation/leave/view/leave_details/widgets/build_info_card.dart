import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'leave_detail_card.dart';

class BuildInfoCard extends StatelessWidget {
  final LeaveDetailsData data;

  const BuildInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        children: [
          LeaveDetailCard(
            icon: Icons.category,
            title: tr('type'),
            value: data.type ?? '',
          ),
          const Divider(height: 0),
          LeaveDetailCard(
            icon: Icons.timelapse,
            title: tr('total_days'),
            value: '${data.totalDays ?? ''} ${tr('days')}',
          ),
          const Divider(height: 0),
          LeaveDetailCard(
            icon: Icons.note,
            title: tr('note'),
            value: data.note ?? '',
          ),
          const Divider(height: 0),
          LeaveDetailCard(
            icon: Icons.person,
            title: tr('substitute'),
            value: data.name ?? tr('add_substitute'),
          ),
        ],
      ),
    );
  }
}
