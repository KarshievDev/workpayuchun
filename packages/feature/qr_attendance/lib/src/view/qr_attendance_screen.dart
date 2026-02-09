import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_attendance/src/bloc/qr_attendance_bloc.dart';
import 'content/content.dart';

class QRAttendanceScreen extends StatelessWidget {
  final String baseUrl;
  final String token;
  final Route callBackRoute;

  const QRAttendanceScreen({super.key, required this.token, required this.baseUrl, required this.callBackRoute});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QRAttendanceBloc(metaClubApiClient: instance(), callBackRoute: callBackRoute),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'QR Attendance',
              style: TextStyle(fontSize: 18),
            ),
          ),
          backgroundColor: Colors.black,
          body: const QRAttendanceContent()),
    );
  }
}
