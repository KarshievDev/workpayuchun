import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class RegistrationData {
  final bool? result;
  final String? error;

  RegistrationData({this.result, this.error});

  factory RegistrationData.fromJson(Map<String, dynamic> json) {
    return RegistrationData(
        result: json['result'],
        error: json['error']);
  }
}

class EventWidgets extends StatelessWidget {
  const EventWidgets(
      {super.key,
      required this.data,
      this.isAppointment = false,
      this.viewAllPressed});

  final MeetingsItem? data;
  final bool? isAppointment;
  final Function()? viewAllPressed;

  @override
  Widget build(BuildContext context) {
    final values = data?.date?.split(' ');
    final month = values?[0];
    final date = values?[1];
    final subStringData = month?.substring(0, 3);
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        )),
        child: Row(children: [
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Colors.blue,
                  ),
                  child: Text(
                    '$subStringData'.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 12.r),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    '$date',
                    style: TextStyle(fontSize: 14.r),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data?.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14.r,
                      color: const Color(0xFF222222),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      letterSpacing: 0.5),
                ),
                Visibility(
                  visible: isAppointment!,
                  child: Row(
                    children: [
                      Text(
                        '${data?.time},',
                        style: TextStyle(
                            fontSize: 12.r,
                            color: const Color(0xFF555555),
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            letterSpacing: 0.5),
                      ),
                      Expanded(
                        child: Text(
                          ' ${data?.location}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.r,
                              color: const Color(0xFF555555),
                              height: 1.4,
                              letterSpacing: 0.5),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
