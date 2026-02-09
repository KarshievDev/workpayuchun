import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/deduction/bloc/deduction/deduction_cubit.dart';
import 'package:strawberryhrm/presentation/deduction/bloc/deduction/deduction_state.dart';
import 'package:strawberryhrm/presentation/deduction/view/contents/deduction_card.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';

typedef DeductionScreenFactory = DeductionScreen Function();

class DeductionScreen extends StatelessWidget {
  final DeductionCubitFactory deductionCubit;

  const DeductionScreen({super.key, required this.deductionCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => deductionCubit(),
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: Text(
              "Deduction Info",
              style: TextStyle(fontSize: 18.r),
            ),
          ),
          body: Builder(builder: (context) {
            return BlocBuilder<DeductionCubit, DeductionState>(builder: (context, state) {
              if (state.status == NetworkStatus.loading) {
                return const GeneralListShimmer();
              } else if (state.deductionData?.deduction?.data.isEmpty == true) {
                return const NoDataFoundWidget();
              } else {
                return  ListView.separated(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  itemCount: state.deductionData?.deduction?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    Deduction? deduction = state.deductionData?.deduction?.data[index];
                    return DeductionCard(deduction: deduction);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 40,
                    );
                  },
                );
              }
            });
          })),
    );
  }
}
