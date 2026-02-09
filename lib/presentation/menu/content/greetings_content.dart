import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strawberryhrm/presentation/home/bloc/bloc.dart';

class GreetingsContent extends StatelessWidget {
  const GreetingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<HomeBloc>().state;
    final dashboard = state.dashboardModel;
    final settings = state.settings;

    return Column(
      children: [
        if (settings?.data?.timeWish != null || dashboard?.data?.config?.timeWish != null)
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.network(
              settings?.data?.timeWish?.image ?? dashboard?.data?.config?.timeWish?.image ?? '',
              semanticsLabel: 'sun',
              height: 20.h,
              width: 20 .w,
              placeholderBuilder: (BuildContext context) => const SizedBox.shrink(),
            ),
          ),
        Text(
          settings?.data?.timeWish?.wish ?? dashboard?.data?.config?.timeWish?.wish ?? '',
          style: TextStyle(fontSize: 13.r, color: Colors.white),
        )
      ],
    );
  }
}
