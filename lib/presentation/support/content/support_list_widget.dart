import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/support/bloc/support_bloc.dart';
import 'package:strawberryhrm/presentation/support/content/support_ticket_item.dart';

class SupportListWidget extends StatelessWidget {
  const SupportListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportBloc, SupportState>(builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state.status == NetworkStatus.success) {
        return state.supportListModel?.data?.data?.isEmpty == true
            ? const Expanded(
                child: NoDataFoundWidget(),
              )
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.supportListModel?.data?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    var item = state.supportListModel?.data?.data?[index];
                    return item != null
                        ? SupportTicketItem(supportModel: item)
                        : const SizedBox.shrink();
                  },
                ),
              );
      } else if (state.status == NetworkStatus.failure) {
        return Center(
          child: const Text("failed_to_load_support_list").tr(),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
