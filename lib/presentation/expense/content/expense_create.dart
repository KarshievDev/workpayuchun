import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/expense/content/expense_create_body_content.dart';

class ExpenseCreate extends StatelessWidget {
  final int? categoryId;
  final String? categoryName;
  const ExpenseCreate({super.key, this.categoryId, this.categoryName});
  @override
  Widget build(BuildContext context) {
    ExpenseCreateBody expenseCreateBody = ExpenseCreateBody();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("create_expanse"),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ExpenseCreateBodyContent(
          categoryName: categoryName,
          categoryId: categoryId,
          expenseCreateBody: expenseCreateBody),
    );
  }
}
