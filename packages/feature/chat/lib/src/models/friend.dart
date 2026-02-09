class Friend {
  final String? uid;
  final String? timeStamp;
  final String? message;

  Friend({this.uid, this.timeStamp, this.message});

  factory Friend.fromJson(Map<dynamic, dynamic> item) {
    return Friend(
      uid: item['uid'] ?? '',
      timeStamp: item['timestamp'] ?? '',
      message: item['message'] ?? '',
    );
  }
}
