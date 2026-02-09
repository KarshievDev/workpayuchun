import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/expense/bloc/expense_bloc.dart';
import 'package:strawberryhrm/presentation/expense/content/expanse_drop_down_content.dart';
import 'package:strawberryhrm/presentation/expense/content/expense_category.dart';
import 'package:strawberryhrm/presentation/expense/content/expense_list_content.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = context.read<AuthenticationBloc>().state.data;
    // final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
      create: (context) => ExpenseBloc(
          metaClubApiClient: MetaClubApiClient(httpService: instance()))
        ..add(GetExpenseData())
        ..add(ExpenseCategory()),
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "expense".tr(),
                style: TextStyle(fontSize: 18.r),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.read<ExpenseBloc>().add(SelectMonthPicker(context));
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ExpenseDropDownContent(state: state),
                  const ExpenseListContent(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                NavUtil.navigateScreen(
                    context,
                    BlocProvider.value(
                        value: context.read<ExpenseBloc>(),
                        child: const ExpenseCategoryPage()));
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
