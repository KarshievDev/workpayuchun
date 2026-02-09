import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/expense/bloc/expense_bloc.dart';

class ExpenseDropDownContent extends StatelessWidget {
  final ExpenseState? state;
  const ExpenseDropDownContent({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.grey, spreadRadius: 1),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                isExpanded: true,
                hint: Text(
                  tr("select_payment"),
                  style: TextStyle(fontSize: 14.r),
                ),
                value: state?.paymentTypeName,
                icon:  Icon(
                  Icons.arrow_downward,
                  size: 18.r,
                ),
                iconSize: 24.r,
                elevation: 16,
                onChanged: (String? newValue) {
                  context
                      .read<ExpenseBloc>()
                      .add(SelectPaymentType(context, newValue));
                },
                items: ["Paid", "Unpaid"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 14.r),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.grey, spreadRadius: 1),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                isExpanded: true,
                hint: Text(
                  tr("expanse_status"),
                  style: TextStyle(fontSize: 14.r),
                ),
                value: state?.statusTypeName,
                icon: Icon(
                  Icons.arrow_downward,
                  size: 18.r,
                ),
                iconSize: 24.r,
                elevation: 16,
                onChanged: (String? newValue) {
                  context
                      .read<ExpenseBloc>()
                      .add(SelectStatus(context, newValue));
                },
                items: ["Pending", "Approved", "Rejected"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 14.r),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
