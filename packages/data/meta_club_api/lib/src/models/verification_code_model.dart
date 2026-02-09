import 'dart:convert';

VerificationCodeModel verificationCodeModelFromJson(String str) =>
    VerificationCodeModel.fromJson(json.decode(str));

String verificationCodeModelToJson(VerificationCodeModel data) =>
    json.encode(data.toJson());

class VerificationCodeModel {
  final bool? result;
  final String? message;

  VerificationCodeModel({
    this.result,
    this.message,
  });

  factory VerificationCodeModel.fromJson(Map<String, dynamic> json) =>
      VerificationCodeModel(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };
}
