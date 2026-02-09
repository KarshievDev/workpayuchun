import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class QrAppBar extends StatelessWidget {
  final VoidCallback onCameraRefresh;
  final VoidCallback onReport;

  const QrAppBar({super.key, required this.onCameraRefresh, required this.onReport});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Branding.colors.primaryLight,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 12),
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title:  Text("Scan QR Code".tr(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        trailing: Wrap(
          children: [
            IconButton(onPressed: onCameraRefresh, icon: const Icon(Icons.refresh, color: Colors.white)),
            IconButton(onPressed: onReport, icon: const Icon(Icons.description_outlined, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
