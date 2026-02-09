class ComplainReplyBody {
  final int? isAppeal;
  final String? explanation;
  final int? isReply;

  ComplainReplyBody({this.isAppeal, this.explanation, this.isReply});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['is_appeal'] = isAppeal;
    map['explaination'] = explanation;
    map['is_reply'] = isReply;
    return map;
  }
}
