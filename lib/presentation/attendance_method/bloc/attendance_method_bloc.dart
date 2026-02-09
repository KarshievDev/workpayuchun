import 'package:camera/camera.dart';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/attendance/attendance.dart';
import 'package:strawberryhrm/presentation/home/bloc/bloc.dart';
import 'package:strawberryhrm/res/dialogs/custom_dialogs.dart';
import 'package:qr_attendance/qr_attendance.dart';
import 'package:selfie_attendance/selfie_attendance.dart';
import 'package:user_repository/user_repository.dart';
import '../../../res/widgets/custom_button.dart';

part 'attendance_method_event.dart';

part 'attendance_method_state.dart';

class AttendanceMethodBloc extends Bloc<AttendanceMethodEvent, AttendanceMethodState> {
  final String _baseUrl;
  final LoginData? _loginData;
  final MetaClubApiClient _metaClubApiClient;

  AttendanceMethodBloc({
    required MetaClubApiClient metaClubApiClient,
    required HomeBloc homeBloc,
    required LoginData? loginData,
    required String baseUrl,
  }) : _baseUrl = baseUrl,
       _loginData = loginData,
       _metaClubApiClient = metaClubApiClient,
       super(const AttendanceMethodState(status: NetworkStatus.initial)) {
    on<AttendanceNavEvent>(onRouteSlug);
  }

  void onRouteSlug(AttendanceNavEvent event, Emitter<AttendanceMethodState> emit) {
    String? selfiePath;

    switch (event.slugName) {
      case 'offline_attendance':
        Navigator.push(event.context, AttendancePage.route());
        break;
      case 'normal_attendance':
        Navigator.push(event.context, AttendancePage.route());
        break;
      case 'face_attendance':

        ///set condition here weather face checking enable or disable
        ///fetch face date from local cache

        break;
      case 'qr_attendance':

        ///navigate into QR feature
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (_) {
              return BlocProvider.value(
                value: event.context.read<HomeBloc>(),
                child: QRAttendanceScreen(
                  token: '${_loginData?.user!.token}',
                  baseUrl: _baseUrl,
                  callBackRoute: AttendancePage.route(attendanceType: AttendanceType.qr),
                ),
              );
            },
          ),
        );
        break;
      case 'selfie_attendance':

        ///navigate into selfie attendance feature
        availableCameras().then((value) {
          if (!event.context.mounted) return null;
          return Navigator.push(
            event.context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: event.context.read<HomeBloc>(),
                    child: AttendanceSelfieScreen(
                      cameras: value,
                      onSelfieCaptured: (XFile selfie) {
                        selfiePath = selfie.path;
                      },
                      callBackButton: CustomHButton(
                        title: tr("next"),
                        clickButton:
                            () {
                              if (event.context.mounted) {
                                Navigator.pushReplacement(
                                  event.context,
                                  AttendancePage.route(attendanceType: AttendanceType.selfie, selfie: selfiePath),
                                );
                              }
                            },
                      ),
                    ),
                  ),
            ),
          );
        });
        break;
      default:
        return;
    }
  }

  void faceDataApi(String? faceData, BuildContext context) async {
    try {
      await _metaClubApiClient.faceDataStore(faceData: faceData).then((data) {
        if (!context.mounted) return;
        Navigator.pop(context);
        data.fold((l) => null, (r) {
          if (r) {
            Fluttertoast.showToast(msg: "Face store successfully");
            if (context.mounted) {
              Navigator.push(context, AttendancePage.route(attendanceType: AttendanceType.face));
            }
          } else {
            if (context.mounted) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CustomDialogFaceError();
                },
              );
            }
          }
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
