import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/daily_report/bloc/daily_report_bloc/daily_report_bloc.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/daily_report_button_widget.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/daily_report_end_time_widget.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/daily_report_error_text_widget.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/daily_report_rating_widget.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/daily_report_start_time_widget.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/daily_report_summary_widget.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/number_of_call_widget.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/positive_leads_today_widget.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/recovery_today_widget.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/select_report_date_widget.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/total_sales_today_widget.dart';
import 'package:strawberryhrm/presentation/daily_report/view/content/update_pending_leads_widget.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/presentation/upload_file/view/upload_doc_content.dart';

class CreateDailyReportPage extends StatefulWidget {
  const CreateDailyReportPage({super.key});

  @override
  State<CreateDailyReportPage> createState() => _CreateDailyReportPageState();
}

class _CreateDailyReportPageState extends State<CreateDailyReportPage> {
  final formKey = GlobalKey<FormState>();
  FileUpload? uploadFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(title: Text("daily_report".tr())),
        body: BlocBuilder<DailyReportBloc, DailyReportState>(
            builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Select Report Date Widget
                    SelectReportDateWidget(state: state),
                    /// Select Start Time Widget
                    DailyReportStartTimeWidget(state: state),
                    /// Select End Time Widget
                    DailyReportEndTimeWidget(state: state),
                    /// Number Of Calls You did Today Widget
                    const NumberOfCallWidget(),
                    /// Positive Leads Today Widget
                    const PositiveLeadsTodayWidget(),
                    /// Total Sales Today Widget
                    const TotalSalesTodayWidget(),
                    /// Did you update your pending and leads Radio button Widget
                    UpdatePendingLeadsWidget(state: state,),
                    /// Did you worked on recovery today Radio Button Widget
                    RecoveryTodayWidget(state: state,),
                    /// Daily Report summary Widget
                    const DailyReportSummaryWidget(),
                    const SizedBox(height: 16),
                    CustomTextField(title: "complaints_questions_comments".tr(), maxLine: 2, hints: "optional".tr(),
                      controller: context.read<DailyReportBloc>().complaintsQuestionsController,
                    ),
                    UploadDocContent(
                      onFileUpload: (FileUpload? data) {
                        uploadFile = data;
                      },
                      initialAvatar: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                    ),
                    /// in terms of production, how was your day Rating
                    const DailyReportRatingWidget(),
                    /// Validation error text widget
                    const DailyReportErrorTextWidget(),
                    /// Daily Report Button Widget
                    DailyReportButtonWidget(state: state, formKey: formKey, uploadFile: uploadFile,),
                    const SizedBox(height: 40.0,),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
