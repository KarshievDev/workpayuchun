import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/support/view/create_support/create_support_page.dart';
import 'package:strawberryhrm/presentation/support/view/support_list_content/support_list_content.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import '../bloc/bloc.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    globalState.get(companyUrl);

    return BlocProvider(
      create: (context) => SupportBloc(
          metaClubApiClient: MetaClubApiClient(
              httpService: instance()))
        ..add(GetSupportData()),
      child: BlocBuilder<SupportBloc, SupportState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: colorPrimary,
              onPressed: () {
                NavUtil.navigateScreen(
                    context,
                    BlocProvider.value(
                      value: context.read<SupportBloc>(),
                      child: const CreateSupportPage(),
                    ));
              },
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
            appBar: AppBar(
              iconTheme: IconThemeData(size: 20.r, color: Colors.white),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF00CCFF),
                        colorPrimary,
                      ],
                      begin: FractionalOffset(3.0, 0.0),
                      end: FractionalOffset(0.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
              title: Text(
                tr("all_support_tickets"),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                    fontSize: 16.r),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      context
                          .read<SupportBloc>()
                          .add(SelectDatePicker(context));
                    },
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      size: 18.r,
                    ))
              ],
            ),
            body: const SupportListContent(),
          );
        },
      ),
    );
  }
}
