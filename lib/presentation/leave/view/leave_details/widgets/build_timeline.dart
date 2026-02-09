import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class BuildTimeline extends StatelessWidget {
  final LeaveDetailsData data;

  const BuildTimeline({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Stepper(
        physics: const NeverScrollableScrollPhysics(),
        controlsBuilder: (_, __) => const SizedBox.shrink(),
        currentStep: 0,
        steps: [
          Step(
            title: Text(tr('requested_on')),
            content: Text(data.requestedOn ?? ''),
            isActive: true,
          ),
          Step(
            title: Text(tr('period')),
            content: Text(data.period ?? ''),
            isActive: true,
          ),
          Step(
            title: Text(tr('approves')),
            content: Text(data.apporover ?? ''),
            isActive: true,
          ),
        ],
      ),
    );
  }
}
