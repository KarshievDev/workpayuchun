import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/expense/bloc/expense_bloc.dart';
import 'package:strawberryhrm/presentation/expense/content/expense_details.dart';
import 'package:strawberryhrm/presentation/expense/content/expense_list_shimmer.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class ExpenseListContent extends StatelessWidget {
  const ExpenseListContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ExpenseBloc>();
    return context.read<ExpenseBloc>().state.responseExpenseList?.data.length != null
        ? bloc.state.responseExpenseList?.data.isNotEmpty == true
            ? Expanded(
                child: ListView.builder(
                  itemCount: bloc.state.responseExpenseList?.data.length ?? 0,
                  itemBuilder: (context, i) {
                    final data = bloc.state.responseExpenseList?.data[i];
                    return InkWell(
                      onTap: () {
                        NavUtil.navigateScreen(context, ExpenseDetails(data: data));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.r),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: ListTile(
                              title: Text(
                                data?.category ?? "".tr(),
                                style: TextStyle(fontSize: 14.r, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(int.parse(data?.statusColor ?? ''.tr())),
                                          style: BorderStyle.solid,
                                          width: 3.0,
                                        ),
                                        color: Color(int.parse(data?.statusColor ?? '')),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: DottedBorder(
                                        color: Colors.white,
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(5),
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                        strokeWidth: 1,
                                        child: Text(
                                          data?.status ?? ''.tr(),
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 10.r, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(int.parse(data?.paymentColor ?? '')),
                                          style: BorderStyle.solid,
                                          width: 3.0,
                                        ),
                                        color: Color(int.parse(data?.paymentColor ?? '')),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: DottedBorder(
                                        color: Colors.white,
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(5),
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                        strokeWidth: 1,
                                        child: Text(
                                          data?.payment ?? ''.tr(),
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 10.r, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Text(
                                data?.dateShow ?? "".tr(),
                                style: TextStyle(fontSize: 12.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : const Expanded(child: NoDataFoundWidget())
        : const ExpenseListShimmer();
  }
}
