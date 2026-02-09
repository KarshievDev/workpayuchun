import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_attendance/src/bloc/qr_attendance_bloc.dart';
import 'package:qr_attendance/src/res/enum.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRAttendanceContent extends StatefulWidget {
  const QRAttendanceContent({super.key});

  @override
  State<StatefulWidget> createState() => _QRAttendanceContentState();
}

class _QRAttendanceContentState extends State<QRAttendanceContent> with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  /// In order to get hot reload to work we need to pause the camera if the platform
  /// is android, or resume the camera if the platform is iOS.a
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      context.read<QRViewController>().pauseCamera();
    } else {
      context.read<QRViewController>().resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QRAttendanceBloc, QRAttendanceState>(
      builder: (context, state) {
        return Stack(
          children: [
            Column(
              children: [
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () async {
                          await context.read<QRAttendanceBloc>().qrViewController.resumeCamera();
                        },
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        )),
                  ),
                ),
                Expanded(flex: 4, child: _buildQrView(context)),
              ],
            ),
            Visibility(
                visible: state.status == NetworkStatus.loading,
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
          ],
        );
      },
    );
  }

  Widget _buildQrView(BuildContext context) {
    ///To ensure the Scanner view is properly sizes after rotation
    ///we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    context.read<QRAttendanceBloc>().qrViewController = controller;
    context.read<QRAttendanceBloc>().qrViewController.scannedDataStream.listen((scanData) {
      if (mounted) {
        context.read<QRAttendanceBloc>().add(QRScanData(qrData: scanData.code, context: context));
        controller.pauseCamera();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    context.read<QRAttendanceBloc>().qrViewController.dispose();
    super.dispose();
  }
}
