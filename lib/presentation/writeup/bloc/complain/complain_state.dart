import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';

class ComplainState extends Equatable {
  final NetworkStatus status;
  final NetworkStatus submitComplain;
  final ComplainData? complainData;
  final ComplainData? verbalWarningData;
  final List<ComplainReply> complainReplies;
  final Failure? failure;
  final String? date;
  final String? deadline;
  final PhoneBookUser? employee;
  final String? document;
  final bool? isAppeal;
  final bool? isAgree;
  final bool writeExplanation;
  final bool directTalkHR;

  const ComplainState(
      {this.status = NetworkStatus.initial,
      this.submitComplain = NetworkStatus.initial,
      this.complainData,
      this.verbalWarningData,
      this.failure,
      this.deadline,
      this.date,
      this.employee,
      this.document,
      this.isAppeal = true,
      this.isAgree,
      this.writeExplanation = true,
      this.directTalkHR = false,
      this.complainReplies = const []});

  ComplainState copyWith(
      {NetworkStatus? status,
      NetworkStatus? submitComplain,
      ComplainData? complainData,
      Failure? failure,
      String? date,
      String? deadline,
      PhoneBookUser? employee,
      String? document,
      ComplainData? verbalWarningData,
      bool? isAppeal,
      bool? isAgree,
      bool? writeExplanation,
      List<ComplainReply>? complainReplies,
      bool? directTalkHR}) {
    return ComplainState(
        status: status ?? this.status,
        submitComplain: submitComplain ?? this.submitComplain,
        complainData: complainData ?? this.complainData,
        failure: failure ?? this.failure,
        date: date ?? this.date,
        deadline: deadline ?? this.deadline,
        employee: employee ?? this.employee,
        document: document ?? this.document,
        isAppeal: isAppeal ?? this.isAppeal,
        isAgree: isAgree ?? this.isAgree,
        verbalWarningData: verbalWarningData ?? this.verbalWarningData,
        directTalkHR: directTalkHR ?? this.directTalkHR,
        writeExplanation: writeExplanation ?? this.writeExplanation,
        complainReplies: complainReplies ?? this.complainReplies);
  }

  @override
  List<Object?> get props => [
        status,
        submitComplain,
        date,
        deadline,
        employee,
        document,
        isAppeal,
        isAgree,
        writeExplanation,
        directTalkHR,
        verbalWarningData,
        complainReplies
      ];
}
