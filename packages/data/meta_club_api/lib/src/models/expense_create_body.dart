class ExpenseCreateBody {
  int? categoryId;
  String? date;
  String? amount;
  String? description;
  String? reference;
  int? attachment;

  ExpenseCreateBody() {
    categoryId = categoryId;
    date = date;
    amount = amount;
    description = description;
    reference = reference;
    attachment = attachment;
  }
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['expense_category_id'] = categoryId;
    map['date'] = date;
    map['amount'] = amount;
    map['description'] = description;
    map['reference'] = reference;
    map['attachment_file'] = attachment;
    return map;
  }
}
