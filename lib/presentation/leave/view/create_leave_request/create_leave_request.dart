import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/presentation/select_employee/view/select_employee.dart';
import 'package:strawberryhrm/presentation/upload_file/view/upload_doc_content.dart';
import '../../../../res/widgets/custom_button.dart';
import '../../leave.dart';

class CreateLeaveRequest extends StatelessWidget {
  final String? starDate;
  final String? endDate;
  final int? leaveTypeId;
  final String? leaveType;
  final int? pendingLeaves;
  final int? leaveBalance;

  const CreateLeaveRequest(
      {super.key,
      this.starDate,
      this.leaveTypeId,
      this.endDate,
      this.leaveType,
      this.pendingLeaves,
      this.leaveBalance});

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      return DateFormat('dd MMM, yyyy').format(DateTime.parse(date));
    } catch (_) {
      return date;
    }
  }

  Widget _infoBox(String label, int? value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: colorPrimary.withAlpha(70)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12.r, color: Colors.black54),
            ),
            SizedBox(height: 4.r),
            Text(
              '${value ?? 0}',
              style: TextStyle(
                fontSize: 16.r,
                fontWeight: FontWeight.w600,
                color: colorPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BodyCreateLeaveModel bodyCreateLeave = BodyCreateLeaveModel();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.r),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            tr("request_leave"),
            style: TextStyle(fontSize: 16.r),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                colorPrimary.withAlpha(30),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leaveType ?? '',
                          style: TextStyle(
                            fontSize: 16.r,
                            fontWeight: FontWeight.w600,
                            color: colorPrimary,
                          ),
                        ),
                        SizedBox(height: 8.r),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14.r,
                              color: colorPrimary,
                            ),
                            SizedBox(width: 4.r),
                            Text(
                              '${_formatDate(starDate)} - ${_formatDate(endDate)}',
                              style: TextStyle(
                                fontSize: 13.r,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.r),
                        Row(
                          children: [
                            _infoBox(tr("pending_leave"), pendingLeaves),
                            SizedBox(width: 12.r),
                            _infoBox(tr("leave_balance"), leaveBalance),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                            title: "note".tr(),
                            hints: "write_reason".tr(),
                            errorMsg: "response_can't_be_empty".tr(),
                            maxLine: 7,
                            onData: (data) {
                              bodyCreateLeave.reason = data;
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        UploadDocContent(
                          onFileUpload: (FileUpload? data) {
                            if (kDebugMode) {
                              print(data?.fileId);
                            }
                            bodyCreateLeave.imageUrl = data?.previewUrl;
                          },
                          initialAvatar:
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                BlocBuilder<LeaveBloc, LeaveState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("substitute"),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.r),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () async {
                            PhoneBookUser employee = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SelectEmployeePage(),
                              ),
                            );
                            if (context.mounted) {
                              context.read<LeaveBloc>().add(SelectEmployee(employee));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                state.selectedEmployee?.name ??
                                    tr("add_a_Substitute"),
                                style: TextStyle(fontSize: 14.r),
                              ),
                              subtitle: Text(
                                  state.selectedEmployee?.designation ??
                                      tr("add_a_Designation"),
                                  style: TextStyle(fontSize: 12.r)),
                              leading: ClipOval(
                                child: CachedNetworkImage(
                                  height: 35.r,
                                  width: 35.r,
                                  fit: BoxFit.cover,
                                  imageUrl: state.selectedEmployee?.avatar ??
                                      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png',
                                  placeholder: (context, url) => Center(
                                    child: Image.asset(
                                      "assets/images/app_icon.png",
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              trailing: Icon(
                                Icons.edit,
                                size: 16.r,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomHButton(
                          title: "next".tr(),
                          padding: 0,
                          backgroundColor: Branding.colors.primaryDark,
                          isLoading: state.status == NetworkStatus.loading,
                          clickButton: () {
                            if (formKey.currentState!.validate() &&
                                state.status != NetworkStatus.loading) {
                              final user =
                                  context.read<AuthenticationBloc>().state.data;
                              bodyCreateLeave.userId = user?.user?.id;
                              bodyCreateLeave.assignLeaveId = leaveTypeId;
                              bodyCreateLeave.substituteId =
                                  state.selectedEmployee?.id;
                              bodyCreateLeave.applyDate = starDate;
                              bodyCreateLeave.leaveTo = endDate;
                              bodyCreateLeave.leaveFrom = starDate;
                              context.read<LeaveBloc>().add(
                                    SubmitLeaveRequest(
                                        bodyCreateLeaveModel: bodyCreateLeave,
                                        uid: user!.user!.id!,
                                        context: context),
                                  );
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
