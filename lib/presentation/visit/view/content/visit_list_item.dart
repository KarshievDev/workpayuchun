import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/visit/view/visit_details_page/visit_details_page.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../bloc/visit_bloc.dart';

class VisitListItem extends StatelessWidget {
  final MyVisit? myVisit;

  const VisitListItem({super.key, this.myVisit});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    if (user?.user != null) {
      final streamLocationUseCase = instance<StreamLocationUseCase>();
      streamLocationUseCase(uid: '${globalState.get(companyId)}${user!.user!.id!}');
    }
    return InkWell(
      onTap: () {
        NavUtil.navigateScreen(
          context,
          BlocProvider.value(value: context.read<VisitBloc>(), child: VisitDetailsPage(visitID: myVisit!.id!)),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.arrow_forward_ios, color: colorPrimary, size: 20),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          myVisit?.title ?? "",
                          style: TextStyle(fontSize: 12.r, color: Colors.black, fontWeight: FontWeight.w600),
                        ).tr(),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(myVisit?.date ?? "", style: TextStyle(fontSize: 10.r)),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(int.parse(myVisit?.statusColor ?? "0xFFFF8F5E")),
                                  style: BorderStyle.solid,
                                  width: 3.0,
                                ),
                                color: Color(int.parse(myVisit?.statusColor ?? "0xFFFF8F5E")),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DottedBorder(
                                color: Colors.white,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(5),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                strokeWidth: 1,
                                child:
                                    Text(
                                      myVisit?.status ?? "",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.r,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ).tr(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
