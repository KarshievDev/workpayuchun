part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExpenseData extends ExpenseEvent {
  final String? date;
  final String? paymentId;
  final String? statusTypeId;
  final String? paymentTypeName;
  final String? statusTypeName;

  GetExpenseData(
      {this.date,
      this.statusTypeId,
      this.paymentId,
      this.paymentTypeName,
      this.statusTypeName});

  @override
  List<Object> get props => [];
}

class SelectMonthPicker extends ExpenseEvent {
  final BuildContext context;
  SelectMonthPicker(this.context);

  @override
  List<Object> get props => [];
}

class SelectPaymentType extends ExpenseEvent {
  final String? paymentType;
  final BuildContext context;
  SelectPaymentType(this.context, this.paymentType);

  @override
  List<Object> get props => [];
}

class SelectStatus extends ExpenseEvent {
  final String? statusType;
  final BuildContext context;
  SelectStatus(this.context, this.statusType);

  @override
  List<Object> get props => [];
}

class ExpenseCategory extends ExpenseEvent {
  ExpenseCategory();

  @override
  List<Object> get props => [];
}

class SelectedCategory extends ExpenseEvent {
  final BuildContext context;
  final Category selectedCategory;

  SelectedCategory(this.context, this.selectedCategory);

  @override
  List<Object> get props => [context, selectedCategory];
}

class SelectDatePicker extends ExpenseEvent {
  final BuildContext context;
  SelectDatePicker(this.context);

  @override
  List<Object> get props => [];
}

class ExpenseCreateButton extends ExpenseEvent {
  final ExpenseCreateBody expenseCreateBody;
  final BuildContext context;
  ExpenseCreateButton(this.context, this.expenseCreateBody);
  @override
  List<Object> get props => [expenseCreateBody];
}
