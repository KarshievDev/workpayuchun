import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

import 'package:core/core.dart';
import '../../bloc/visit_bloc.dart';

class VisitEmployeeInfo extends StatelessWidget {
  final LoginData? user;

  const VisitEmployeeInfo({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
          child: Text(
            tr("employee"),
            style:  TextStyle(
                color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            title: Text(
              user?.user?.name ?? "",
              style:  TextStyle(
                  color: Colors.black,
                  fontSize: 12.r,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user?.user?.email ?? "",
                style:  TextStyle(
                    color: Colors.black,
                    fontSize: 12.r,
                    fontWeight: FontWeight.bold)),
            leading: ClipOval(
              child: CachedNetworkImage(
                height: 50.r,
                width: 50.r,
                fit: BoxFit.cover,
                imageUrl: "${user?.user?.avatar}",
                placeholder: (context, url) => Center(
                  child: Image.asset("assets/images/placeholder_image.png"),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
          child: Text(
            tr("date*"),
            style:  TextStyle(
                color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
          ),
        ),
        BlocBuilder<VisitBloc, VisitState>(
            builder: (BuildContext context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  context.read<VisitBloc>().add(SelectDatePickerEvent(context));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.currentDate?.isEmpty == true
                            ? "selected_date"
                            : state.currentDate ?? "selected_date",
                        style:  TextStyle(
                            color: Colors.black,
                            fontSize: 12.r,
                            fontWeight: FontWeight.bold),
                      ).tr(),
                       Icon(Icons.date_range_outlined, size: 22.r,)
                    ],
                  ),
                ),
              ),
              state.isDateEnable == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: const Text(
                        "you_must_select_a_visit_date",
                        style: TextStyle(color: colorDeepRed, fontSize: 12),
                      ).tr(),
                    )
                  : const SizedBox()
            ],
          );
        }),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
