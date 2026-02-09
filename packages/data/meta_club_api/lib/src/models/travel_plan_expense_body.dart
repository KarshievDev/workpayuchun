class TravelPlanExpenseBody {
  final String? date;
  final int? travelId;
  final List<int>? fileIds;
  final String? modeOfTransportation;
  final int? rating;
  final List<int>? categoryIds;
  final List<double>? amounts;
  final List<String>? remarks;

  TravelPlanExpenseBody(
      { this.date,
       this.travelId,
       this.fileIds,
       this.modeOfTransportation,
       this.rating,
       this.categoryIds,
       this.amounts,
       this.remarks});

  Map<String, dynamic> toJson() {
    return {
      "travel_plan_id": travelId,
      "date": date, // Y-m-d format
      "mode_of_transportation": modeOfTransportation,
      "rating": rating, // 1,2,3,4,5
      "expense_category_id": categoryIds,
      "amount": amounts,
      "file_id": fileIds,
      "remark": remarks
    };
  }
}
