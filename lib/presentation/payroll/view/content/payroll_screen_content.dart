import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/payroll/payroll.dart';
import 'generate_payroll_shimmer.dart';

class PayrollScreenContent extends StatelessWidget {
  const PayrollScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayrollBloc, PayrollState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Payroll'.tr()),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<PayrollBloc>().add(SelectDatePicker(context));
                },
                icon: Icon(Icons.calendar_month,size: 24.r,))
          ],
        ),
        body: Stack(
          children: [
            if (state.isLoading == true)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: GeneratePayrollShimmer(),
              ),
            if (state.isLoading == false)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Year ${getDateAsString(format: 'y', dateTime: state.dateTime)}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.r),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Table(
                          border: TableBorder.all(width: 0.5),
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(),
                            1: FlexColumnWidth(),
                            2: FlexColumnWidth(),
                            3: FlexColumnWidth(),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: <TableRow>[
                            TableRow(
                              children: [
                                HeaderTableRow(title: 'month'.tr()),
                                Center(
                                    child:
                                        HeaderTableRow(title: 'salary'.tr())),
                                Center(
                                    child:
                                        HeaderTableRow(title: 'payslip'.tr())),
                                Center(
                                  child: HeaderTableRow(title: 'share'.tr()),
                                ),
                              ],
                            ),
                            ...List.generate(
                                state.payroll?.payrollListData?.length ?? 0,
                                (index) {
                              final data =
                                  state.payroll?.payrollListData?[index];
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0).r,
                                    child: Text(
                                      data?.month ?? '',
                                      style:  TextStyle(
                                          fontStyle: FontStyle.italic, fontSize: 12.r),
                                    ).tr(),
                                  ),
                                  Center(
                                    child: Text(
                                      data?.salary.toString() ?? '',
                                      style:  TextStyle(
                                          fontStyle: FontStyle.italic ,fontSize: 12.r),
                                    ),
                                  ),
                                  Center(
                                    child: data?.isCalculated == true
                                        ? InkWell(
                                            onTap: () => context
                                                .read<PayrollBloc>()
                                                .getPaySlip(data!.payslipLink!),
                                            child: Text('download'.tr(),
                                                style:  TextStyle(
                                                    fontSize: 12.r,
                                                    fontStyle: FontStyle.italic,
                                                    decoration: TextDecoration
                                                        .underline)),
                                          ) :  Text(
                                            '',
                                            style: TextStyle(
                                                fontSize: 12.r,
                                                fontStyle: FontStyle.italic,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                  ),
                                  Center(
                                    child: data?.isCalculated == true
                                        ? InkWell(
                                            onTap: () => context
                                                .read<PayrollBloc>()
                                                .sharePaySlip(
                                                    data!.payslipLink!),
                                            child: Text('share'.tr(),
                                                style:  TextStyle(
                                                    fontSize: 12.r,
                                                    fontStyle: FontStyle.italic,
                                                    decoration: TextDecoration
                                                        .underline)),
                                          )
                                        : const Text(
                                            '',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            Positioned(
                child: state.payroll?.payrollListData?.isEmpty == true
                    ? const NoDataFoundWidget()
                    : const SizedBox())
          ],
        ),
      );
    });
  }
}
