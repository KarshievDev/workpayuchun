import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';

class DailyReportButtonWidget extends StatelessWidget {
  final DailyReportState? state;
  final GlobalKey<FormState>? formKey;
  final FileUpload? uploadFile;
  const DailyReportButtonWidget({super.key,this.state,this.formKey,this.uploadFile});

  @override
  Widget build(BuildContext context) {
    return CustomHButton(
      isLoading: state?.status == NetworkStatus.loading,
      padding: 0,
      backgroundColor: Branding.colors.primaryLight,
      title: tr("Submit"),
      clickButton: () {
        if (formKey!.currentState!.validate()) {
          context.read<DailyReportBloc>().add(OnDailyReportSubmitEvent(context: context, fileId: uploadFile?.fileId));
        }
      },
    );
  }
}
