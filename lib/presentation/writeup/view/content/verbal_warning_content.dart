import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/verbal_wraning/verbal_warning_bloc.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/verbal_wraning/verbal_warning_state.dart';
import 'package:strawberryhrm/presentation/writeup/view/content/verbal_warning_card.dart';

class VerbalWarningContent extends StatelessWidget {
  const VerbalWarningContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerbalWarningBloc, VerbalWarningState>(
      builder: (context, state) {
        return state.status == NetworkStatus.loading
            ? const GeneralListShimmer()
            : state.verbalWarningData?.complains.isNotEmpty == true
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: state.verbalWarningData?.complains.length,
                    itemBuilder: (context, index) {
                      final complain = state.verbalWarningData?.complains.elementAtOrNull(index);
                      return complain != null
                          ? VerbalWarningCard(
                              complain: complain,
                            )
                          : const SizedBox.shrink();
                    })
                : const NoDataFoundWidget();
      },
    );
  }
}
