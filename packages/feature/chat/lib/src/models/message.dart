import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? message;
  final String? from;
  final String? timeStamp;
  final String? type;
  final String? status;

  Message({this.message, this.from, this.timeStamp, this.type, this.status});

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'status': status,
        'from': from,
        'timestamp': '${Timestamp.now().seconds}'
      };
}
