import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/break/view/break_page.dart';
import 'package:strawberryhrm/presentation/break/view/break_qr_code/break_qr_scanner_page.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import '../home/bloc/home_bloc.dart';

class BreakRoute {
  static breakOrQrCompanyRoute({required BuildContext context,required bool inBreak}) {
    if (inBreak == false) {
      NavUtil.navigateScreen(context, BreakQrScannerPage(homeBloc: context.read<HomeBloc>()));
    } else {
      Navigator.of(context).push(BreakScreen.route(homeBloc: context.read<HomeBloc>()));
    }
  }
}
