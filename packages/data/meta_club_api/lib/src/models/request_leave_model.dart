import 'package:equatable/equatable.dart';

class SubmitLeaveModel extends Equatable{
  final bool? result;
  final String? message;

  const SubmitLeaveModel({
    this.result,
    this.message,
  });

  factory SubmitLeaveModel.fromJson(Map<String, dynamic> json) => SubmitLeaveModel(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message
  };

  @override
  List<Object?> get props => [result,message];
}
