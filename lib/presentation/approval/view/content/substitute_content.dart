import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../../res/widgets/card_tile_with_content.dart';

class SubstituteContent extends StatelessWidget {
  const SubstituteContent({
    super.key,
    required this.data,
  });

  final ApprovalDetailsData? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: data?.substitute != null
          ? const EdgeInsets.symmetric(vertical: 8.0)
          : EdgeInsets.zero,
      padding: data?.substitute != null
          ? const EdgeInsets.symmetric(vertical: 10.0)
          : EdgeInsets.zero,
      child: data?.substitute != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text('substitute',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: const Color(0xFF6B6A70), fontSize: 12.r))
                      .tr(),
                ),
                const SizedBox(
                  height: 4,
                ),
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4).r,
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(data?.substitute?.avatar ?? ''),
                    ),
                    title: Text(data?.substitute?.name ?? '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12.r)),
                    subtitle: Text(data?.substitute?.designation ?? '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10.r)),
                  ),
                )
              ],
            )
          : const CardTileWithContent(title: 'substitute', value: 'N/A'),
    );
  }
}
