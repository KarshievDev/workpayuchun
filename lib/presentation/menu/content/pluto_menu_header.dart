import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../authentication/bloc/authentication_bloc.dart';

class PlutoMenuHeader extends StatelessWidget {
  const PlutoMenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user?.user?.name ?? "", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.r,color: Colors.white),),
          SizedBox(height: 5.h,),
          Text("view_profile".tr(), style: TextStyle(fontSize: 14.r, color: Colors.white),),
        ],
      ),
    );
  }
}
