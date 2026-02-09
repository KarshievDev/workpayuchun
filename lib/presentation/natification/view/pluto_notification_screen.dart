import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/natification/bloc/notification_bloc.dart';
import 'package:strawberryhrm/presentation/natification/pluto_content/pluto_notification_cart_content.dart';

class PlutoNotificationScreen extends StatelessWidget {
  const PlutoNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NotificationBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))
          ..add(LoadNotificationData()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(tr("notifications",), style: TextStyle(fontSize: 16.r,color: Branding.colors.textPrimary,fontWeight: FontWeight.w500),),
                actions: [
                  Visibility(
                    visible: state.notificationResponse?.data?.notifications?.isNotEmpty ?? false,
                    // visible: true,
                    child: InkWell(
                      onTap: () {
                        context.read<NotificationBloc>().add(ClearNoticeButton());
                        context.read<NotificationBloc>().add(LoadNotificationData());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(CupertinoIcons.delete),
                            Text(tr("clear_all"), style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 10.r),),
                            const SizedBox(width: 16,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  state.notificationResponse?.data?.notifications?.isNotEmpty == true
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: state.notificationResponse?.data?.notifications?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final data = state.notificationResponse?.data?.notifications?[index];

                              return InkWell(
                                onTap: () {
                                  context.read<NotificationBloc>().add(RouteSlug(context: context, slugName: state.notificationResponse?.data?.notifications?[index].slag, data: state.notificationResponse));
                                },
                                child: PlutoNotificationCartContent(data: data),
                              );
                            },
                          ),
                        )
                      : const Expanded(child: NoDataFoundWidget())
                  // : const SizedBox(),
                ],
              ));
        }));
  }
}
