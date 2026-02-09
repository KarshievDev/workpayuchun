import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/phonebook/phonebook.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../leave/view/content/general_list_shimmer.dart';

class MultiSelectEmployeeList extends StatelessWidget {
  const MultiSelectEmployeeList({super.key});

  @override
  Widget build(BuildContext context) {

    RefreshController refreshController = RefreshController(initialRefresh: false);

    return BlocListener<PhoneBookBloc, PhoneBookState>(
      listenWhen: (oldState, newState) => oldState != newState,
      listener: (context, state) {
        if (state.refreshStatus == PullStatus.loaded) {
          refreshController.refreshCompleted();
        }
      },
      child: BlocBuilder<PhoneBookBloc, PhoneBookState>(
          builder: (context, state) {
              return state.phoneBookUsers?.isNotEmpty == true ? ListView.builder(
                itemCount: state.phoneBookUsers?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      context.read<PhoneBookBloc>().add(DoMultiSelectionEvent(state.phoneBookUsers![index]));
                    },
                    onLongPress: () async{
                      context.read<PhoneBookBloc>().add(IsMultiSelectionEnabled(true));
                      context.read<PhoneBookBloc>().add(DoMultiSelectionEvent(state.phoneBookUsers![index]));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 4.r),
                        title: Text(state.phoneBookUsers?[index].name ?? "", style: TextStyle(fontSize: 14.r),),
                        subtitle: Text(state.phoneBookUsers?[index].designation ?? "", style: TextStyle(fontSize: 12.r),),
                        leading: ClipOval(
                          child: CachedNetworkImage(height: 40.r, width: 40.r,
                            fit: BoxFit.cover,
                            imageUrl: "${state.phoneBookUsers?[index].avatar}",
                            placeholder: (context, url) => Center(
                              child: Image.asset("assets/images/placeholder_image.png"),),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                        trailing: Visibility(
                          visible: state.isMultiSelectionEnabled,
                          child: Icon(state.selectedItems.contains(state.phoneBookUsers![index])
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            size: 26.r,
                            color: const Color(0xFF5DB226),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ) : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: GeneralListShimmer(),
              );
          }),
    );
  }
}
