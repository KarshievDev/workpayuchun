import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/presentation/internet_connectivity/bloc/internet_bloc.dart';


class DeviceOfflineView extends StatelessWidget {
  final Widget child;

  const DeviceOfflineView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final internetStatus = context.watch<InternetBloc>().state.status;

    return Scaffold(
      body: Column(
        children: [
          if (internetStatus == InternetStatus.offline)
            Container(
              color: colorDeepRed,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.dangerous_outlined, color: Colors.white),
                  const SizedBox(width: 8.0),
                  const Text('you_are_offline', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)).tr(),
                ],
              ),
            ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
