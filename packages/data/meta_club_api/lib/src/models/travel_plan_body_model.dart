class TravelPlanBody {
  String? fromDate;
  String? toDate;
  String? fromLocation;
  String? toLocation;
  String? purpose;
  String? amount;
  String? signature;
  String? signatureDate;

  TravelPlanBody({
    this.fromDate,
    this.toDate,
    this.fromLocation,
    this.toLocation,
    this.purpose,
    this.amount,
    this.signature,
    this.signatureDate,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["from_date"] = fromDate;
    map["to_date"] = toDate;
    map["from_location"] = fromLocation;
    map["to_location"] = toLocation;
    map["purpose"] = purpose;
    map["amount"] = amount;
    map["signature"] = signature;
    map["signature_date"] = signatureDate;
    return map;
  }

}
