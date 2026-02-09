import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/expense/content/expense_details_item_cart.dart';

class ExpenseDetails extends StatelessWidget {
  final ExpenseItem? data;
  final int? expenseId;
  const ExpenseDetails({super.key, this.expenseId, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 4, title: Text('expense_details'.tr())),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        child: Column(
          children: [
            ExpenseDetailsItemCart(
              title: "requested_amount".tr(),
              value: data?.requestedAmount,
            ),
            ExpenseDetailsItemCart(
              title: "approved_amount".tr(),
              value: data?.approvedAmount,
            ),
            ExpenseDetailsItemCart(
              title: "date_show".tr(),
              value: data?.dateShow,
            ),
            ExpenseDetailsItemCart(
              title: "payment".tr(),
              value: data?.payment,
            ),
            ExpenseDetailsItemCart(
              title: "status".tr(),
              value: data?.status,
            ),
            ExpenseDetailsItemCart(
              title: "reason".tr(),
              value: data?.reason ?? 'no_reason_available'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
