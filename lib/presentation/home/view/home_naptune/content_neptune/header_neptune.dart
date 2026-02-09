import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../authentication/bloc/authentication_bloc.dart';
import '../../../bloc/home_bloc.dart';

class HeaderNeptune extends StatelessWidget {
  const HeaderNeptune({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<HomeBloc>().state.settings;
    final user = context.read<AuthenticationBloc>().state.data;
    final homeData = context.read<HomeBloc>().state.dashboardModel;
    return Column(
      children: [
        SizedBox(height: 10.0.h,),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(settings?.data?.timeWish?.wish ?? homeData?.data?.config?.timeWish?.wish ?? '',
                        style: TextStyle(fontSize: 20.r, color: Colors.white, fontWeight: FontWeight.bold)),),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text('${user?.user?.name}',
                      style: TextStyle(fontSize: 14.r, fontWeight: FontWeight.bold, height: 1.5, color: Colors.white),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 16.0),
                    child: Text(settings?.data?.timeWish?.subTitle ?? homeData?.data?.config?.timeWish?.wish ?? '',
                      style: TextStyle(fontSize: 14.r, fontWeight: FontWeight.w400, height: 1.5, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            if (settings?.data?.timeWish != null || homeData?.data?.config?.timeWish != null)
              SvgPicture.network(settings?.data?.timeWish?.image ?? homeData?.data?.config?.timeWish?.image ?? '', semanticsLabel: 'sun', height: 60.h, width: 60.w, placeholderBuilder: (BuildContext context) => const SizedBox(),),
            const SizedBox(width: 10,)
          ],
        ),
        SizedBox(height: 16.0.h,),
      ],
    );
  }
}
