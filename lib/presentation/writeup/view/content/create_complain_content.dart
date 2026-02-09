import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/presentation/select_employee/view/select_employee.dart';
import 'package:strawberryhrm/presentation/upload_file/view/upload_doc_content.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/complain/complain_bloc.dart';
import 'package:strawberryhrm/presentation/writeup/bloc/complain/complain_state.dart';
import 'package:strawberryhrm/res/widgets/date_picker_widget.dart';

class CreateComplainContent extends StatelessWidget {

  final Key formKey;

  const CreateComplainContent({super.key,required this.formKey});

  @override
  Widget build(BuildContext context) {

    return Form(
      key: formKey,
      child: BlocBuilder<ComplainBloc, ComplainState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8.0,
                ),
                CustomTextField(
                  title: "Title",
                  maxLine: 1,
                  errorMsg: "*Required field",
                  controller: context.read<ComplainBloc>().titleController,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                CustomTextField(
                  title: "Description",
                  hints: "Write say something..",
                  errorMsg: "*Required field",
                  maxLine: 4,
                  controller: context.read<ComplainBloc>().descriptionController,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  "Date",
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                CustomDatePicker(
                  label: state.date ?? 'Select date',
                  onDatePicked: (DateTime date) {
                    context.read<ComplainBloc>().onDateUpdated(date: DateFormat('yyyy-MM-dd').format(date));
                  },
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  "Response Date",
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                CustomDatePicker(
                  label: state.deadline ?? 'Select response date',
                  onDatePicked: (DateTime date) {
                    context.read<ComplainBloc>().onDeadlineUpdated(date: DateFormat('yyyy-MM-dd').format(date));
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "complain_to".tr(),
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.r),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectEmployeePage()))
                          .then((employee) {
                        if (context.mounted) {
                          context.read<ComplainBloc>().onEmployeeSelected(employee: employee);
                        }
                      });
                    },
                    title: Text(
                      state.employee?.name! ?? tr("add_a_Substitute"),
                      style: TextStyle(fontSize: 16.r),
                    ),
                    subtitle: Text(
                      state.employee?.designation! ?? tr("add_a_Designation"),
                      style: TextStyle(fontSize: 14.r),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(state.employee?.avatar ??
                          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                    ),
                    trailing: const Icon(Icons.edit),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                UploadDocContent(
                  onFileUpload: (FileUpload? data) {
                    context.read<ComplainBloc>().onDocumentUpdated(document: data?.previewUrl);
                  },
                  initialAvatar: state.document ??
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
