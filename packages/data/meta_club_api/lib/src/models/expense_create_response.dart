class ExpenseCreateResponse {
  final bool success;
  final String message;

  ExpenseCreateResponse({required this.success, required this.message});

  factory ExpenseCreateResponse.fromJson(Map<String, dynamic> json) {
    return ExpenseCreateResponse(
        success: json['result'], message: json['message']);
  }
}
