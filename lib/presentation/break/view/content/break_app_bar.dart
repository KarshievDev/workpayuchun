import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/break/bloc/break_bloc.dart';
import 'package:strawberryhrm/presentation/break/view/content/break_report_screen.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class BreakAppBar extends StatelessWidget {
  final String? title;

  const BreakAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Branding.colors.primaryLight,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 12),
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          title ?? "".tr(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        trailing: IconButton(
            onPressed: () async {},
            icon: InkWell(
                onTap: () {
                  NavUtil.navigateScreen(
                      context, BlocProvider.value(value: context.read<BreakBloc>(), child: const BreakReportScreen()));
                },
                child: const Icon(Icons.description_outlined, color: Colors.white))),
      ),
    );
  }
}
