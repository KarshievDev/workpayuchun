import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_radio_title.dart';
import '../bloc/support_bloc.dart';

class PriorityIdWidget extends StatelessWidget {
  const PriorityIdWidget({
    super.key,
    required this.createSupport,
  });

  final BodyCreateSupport createSupport;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportBloc, SupportState>(builder: (context, state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomRadioTitle(
              groupValue: state.bodyPrioritySupport,
              value: BodyPrioritySupport(
                  priorityName: 'high'.tr(), priorityId: 14),
              onChanged: (priorityValue) {
                context
                    .read<SupportBloc>()
                    .add(GetPriority(bodyPrioritySupport: priorityValue!));
                createSupport.priorityId = 14;
              },
              title: 'high'.tr(),
            ),
          ),
          Expanded(
            child: CustomRadioTitle(
              groupValue: state.bodyPrioritySupport,
              value: BodyPrioritySupport(
                  priorityName: 'medium'.tr(), priorityId: 15),
              onChanged: (priorityValue) {
                context
                    .read<SupportBloc>()
                    .add(GetPriority(bodyPrioritySupport: priorityValue!));
                createSupport.priorityId = 15;
              },
              title: 'medium'.tr(),
            ),
          ),
          Expanded(
            child: CustomRadioTitle(
              groupValue: state.bodyPrioritySupport,
              value:
                  BodyPrioritySupport(priorityName: 'low'.tr(), priorityId: 16),
              onChanged: (priorityValue) {
                context
                    .read<SupportBloc>()
                    .add(GetPriority(bodyPrioritySupport: priorityValue!));
                createSupport.priorityId = 16;
              },
              title: 'low'.tr(),
            ),
          ),
        ],
      );
    });
  }
}
