import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/phonebook/phonebook.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PhoneBookEmployees extends StatelessWidget {
  const PhoneBookEmployees({super.key});

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
          buildWhen: (oldState, newState) => oldState != newState,
          builder: (context, state) {
            if (state.phoneBookUsers != null) {
              return state.phoneBookUsers?.isEmpty == true
                  ? const NoDataFoundWidget()
                  : SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const WaterDropHeader(),
                      footer: CustomFooter(builder: (context, mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = const Text("Pull up load");
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = const Text("Load Failed!Click retry!");
                        } else if (mode == LoadStatus.canLoading) {
                          body = const Text("release to load more");
                        } else {
                          body = const Text("No more Data");
                        }
                        return SizedBox(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      }),
                      controller: refreshController,
                      onLoading: () {
                        context.read<PhoneBookBloc>().add(PhoneBookLoadMore());
                        refreshController.loadComplete();
                      },
                      onRefresh: () {
                        context.read<PhoneBookBloc>().add(PhoneBookLoadRefresh());
                      },
                      child: ListView.builder(
                        itemCount: state.phoneBookUsers?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  PhoneBookDetailsScreen.route(
                                      homeBloc: context.read<PhoneBookBloc>(),
                                      userId: '${state.phoneBookUsers![index].id}'));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                title: Text(
                                  state.phoneBookUsers?[index].name ?? "",
                                  style: TextStyle(fontSize: 14.r),
                                ),
                                subtitle: Text(state.phoneBookUsers?[index].designation ?? "",
                                    style: TextStyle(fontSize: 13.r)),
                                leading: ClipOval(
                                  child: CachedNetworkImage(
                                    height: 40.r,
                                    width: 35.r,
                                    fit: BoxFit.cover,
                                    imageUrl: "${state.phoneBookUsers?[index].avatar}",
                                    placeholder: (context, url) => Center(
                                      child: Image.asset("assets/images/placeholder_image.png"),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    /// Dial
                                    context
                                        .read<PhoneBookBloc>()
                                        .add(DirectPhoneCall(state.phoneBookUsers?[index].phone ?? ''));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.phone,
                                      size: 20.r,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
