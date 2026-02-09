import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/complain/complain_bloc.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/complain/complain_state.dart';
import 'package:strawberryhrm/presentation/writeup/view/content/complain_card.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'complain_details.dart';

class ComplainContent extends StatelessWidget {
  const ComplainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplainBloc, ComplainState>(
      builder: (context, state) {
        return state.status == NetworkStatus.loading
            ? const GeneralListShimmer()
            : state.complainData?.complains.isNotEmpty == true
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: state.complainData?.complains.length,
                    itemBuilder: (context, index) {
                      final complain = state.complainData?.complains.elementAtOrNull(index);
                      return complain != null
                          ? ComplainCard(
                              complain: complain,
                              onTap: () {
                                if(complain.id != null){
                                  context.read<ComplainBloc>().loadComplainReplies(complainId: complain.id!);
                                }

                                NavUtil.navigateScreen(
                                    context,
                                    BlocProvider.value(
                                        value: context.read<ComplainBloc>(),
                                        child: ComplainDetailsPage(complain: complain)));
                              },
                            )
                          : const SizedBox.shrink();
                    })
                : const NoDataFoundWidget();
      },
    );
  }
}
