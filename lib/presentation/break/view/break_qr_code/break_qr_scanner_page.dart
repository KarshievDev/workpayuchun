import 'dart:developer';
import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/break/bloc/break_bloc.dart';
import 'package:strawberryhrm/presentation/break/view/break_back_type_screen.dart';
import 'package:strawberryhrm/presentation/break/view/content/break_report_screen.dart';
import 'package:strawberryhrm/presentation/break/view/content/qr_app_bar.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BreakQrScannerPage extends StatefulWidget {
  final HomeBloc homeBloc;

  const BreakQrScannerPage({super.key, required this.homeBloc});

  @override
  State<BreakQrScannerPage> createState() => _BreakQrScannerPageState();
}

class _BreakQrScannerPageState extends State<BreakQrScannerPage> with SingleTickerProviderStateMixin {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  /// In order to get hot reload to work we need to pause the camera if the platform
  /// is android, or resume the camera if the platform is iOS.a
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final breakBackBloc = instance<BreakBlocFactory>();
    return BlocProvider(
      create: (context) => breakBackBloc()..add(GetBreakHistoryData()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: AppBar(automaticallyImplyLeading: false),
            ),
            body: Column(
              children: [
                QrAppBar(
                  onCameraRefresh: () {
                    controller?.resumeCamera();
                    setState(() {});
                  },
                  onReport: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (_) =>
                                BlocProvider.value(value: context.read<BreakBloc>(), child: const BreakReportScreen()),
                      ),
                    );
                  },
                ),
                const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colorPrimary, width: 4),
                    ),
                    child: _buildQrView(context, widget.homeBloc),
                  ),
                ),
                const Expanded(flex: 2, child: SizedBox()),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQrView(BuildContext context, HomeBloc bloc) {
    ///To ensure the Scanner view is properly sizes after rotation
    ///we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) => _onQRViewCreated(controller, context, bloc),
      overlay: QrScannerOverlayShape(borderColor: Colors.white, borderRadius: 10, borderLength: 30, borderWidth: 10),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context, HomeBloc bloc) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      debugPrint("QR Code : ${scanData.code}");
      if (scanData.code != null) {
        if (!context.mounted) return;
        context.read<BreakBloc>().add(BreakVerifyQREvent(code: scanData.code!));
        controller.pauseCamera();
        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(value: context.read<BreakBloc>(), child: BreakBackTypeScreen(homeBloc: bloc)),
            ),
          );
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('no Permission')));
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
