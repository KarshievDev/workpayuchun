import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/deduction/bloc/deduction/deduction_cubit.dart';
import 'package:strawberryhrm/presentation/deduction/view/appeal_page.dart';
import 'package:strawberryhrm/presentation/deduction/view/contents/appeal_button.dart';
import 'package:strawberryhrm/presentation/deduction/view/contents/deduction_info_left_widget.dart';
import 'package:strawberryhrm/presentation/deduction/view/contents/details_button.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'deduction_details.dart';

class DeductionCard extends StatelessWidget {
  final Deduction? deduction;

  const DeductionCard({super.key, this.deduction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 1,
              child: DeductionInfoLeftWidget(isAppeal: true),
            ),
            const SizedBox(height: 170, child: VerticalDivider(width: 20, thickness: 1, color: Colors.black)),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deduction?.month ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deduction?.amount ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deduction?.considerAmount ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deduction?.isAppealed ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      deduction?.appealEnable == 0
                          ? Fluttertoast.showToast(msg: "You can't Appeal for it!")
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                      value: context.read<DeductionCubit>(), child: AppealPage(deduction: deduction))));
                    },
                    child: AppealButton(deduction: deduction),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                      onTap: () {
                        NavUtil.navigateScreen(
                            context, DeductionDetailsPage(deductionDetails: deduction?.deductionDetails));
                      },
                      child: const DetailsButton()),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
