import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/expense/bloc/expense_bloc.dart';
import 'package:strawberryhrm/presentation/expense/content/expense_create.dart';
import 'package:strawberryhrm/presentation/expense/content/expense_list_shimmer.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class ExpenseCategoryPage extends StatefulWidget {
  const ExpenseCategoryPage({
    super.key,
  });

  @override
  State<ExpenseCategoryPage> createState() => _ExpenseCategoryPageState();
}

class _ExpenseCategoryPageState extends State<ExpenseCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              tr("expense_log"),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.r),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("select_type_of_expense"),
                  style: TextStyle(
                      fontSize: 14.r,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                state.expenseCategoryData?.data?.categories?.isNotEmpty == true
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: state.expenseCategoryData?.data?.categories
                                  ?.length ??
                              0,
                          itemBuilder: (BuildContext context, int index) {
                            final data = state
                                .expenseCategoryData?.data?.categories?[index];
                            return Padding(
                              padding:
                                   EdgeInsets.symmetric(vertical: 3.0.r),
                              child: Card(
                                elevation: 4,
                                child: RadioListTile<Category?>(
                                  title: Text(
                                    data?.name ?? '',
                                    style: TextStyle(fontSize: 16.r),
                                  ),
                                  value: data,
                                  groupValue: state.selectedCategory,
                                  onChanged: (Category? newValue) {
                                    setState(() {
                                      context.read<ExpenseBloc>().add(
                                          SelectedCategory(context, newValue!));
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const ExpenseListShimmer(),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 45.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (state.selectedCategory?.id != null) {
                        NavUtil.replaceScreen(
                            context,
                            BlocProvider.value(
                                value: context.read<ExpenseBloc>(),
                                child: ExpenseCreate(
                                  categoryId: state.selectedCategory?.id,
                                  categoryName: state.selectedCategory?.name,
                                )));
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(colorPrimary),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Text(tr("next"),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0.r,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
