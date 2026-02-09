import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

import 'package:core/core.dart';
import '../../bloc/visit_bloc.dart';
import '../update_visit/update_visit.dart';

class VisitAppBarAction extends StatelessWidget {
  final int visitID;
  const VisitAppBarAction({super.key,required this.visitID});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        NavUtil.navigateScreen(
            context,
            BlocProvider.value(
                value: context.read<VisitBloc>(),
                child:  UpdateVisit(visitID: visitID,)));
      },
      child:  Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: CircleAvatar(
          radius: 12,
          backgroundColor: Colors.white,
          child: ClipOval(
              child: Icon(
            Icons.edit,
            size: 12.r,
            color: colorPrimary,
          )),
        ),
      ),
    );
  }
}
