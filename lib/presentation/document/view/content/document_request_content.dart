import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/document/bloc/document_bloc.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/presentation/select_employee/view/select_employee.dart';
import 'package:strawberryhrm/presentation/upload_file/view/upload_doc_content.dart';
import 'package:strawberryhrm/res/widgets/date_picker_widget.dart';
import 'custom_drop_down.dart';

class DocumentRequestContent extends StatelessWidget {
  const DocumentRequestContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8.0,
              ),
              CustomDocumentTypeDropDown(
                items: state.documentTypes?.types ?? [],
                item: state.docType,
                title: "Document Type",
                hint: "Select Document",
                onChange: (type) {
                  context.read<DocumentBloc>().add(OnSelectDocType(type));
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              if(state.docType != null)...[
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    dense: true,
                    tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    title: const Text(
                      "Sample template",
                      style: TextStyle(color: Colors.black38, fontSize: 11.0),
                    ),
                    children: [
                      Html(data: state.docType?.requestTemplate ?? '')
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
              CustomTextField(
                title: "Application",
                hints: "Write say something..",
                maxLine: 5,
                controller: context.read<DocumentBloc>().controller,
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                "Due Date",
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              CustomDatePicker(
                label: state.date ?? 'Select date',
                onDatePicked: (DateTime date) {
                  context.read<DocumentBloc>().add(OnSelectDate(date: DateFormat('yyyy-MM-dd').format(date)));
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "appointment_with".tr(),
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.r),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectEmployeePage()))
                        .then((employee) {
                      if (context.mounted) {
                        context.read<DocumentBloc>().add(OnSelectEmployee(employee));
                      }
                    });
                  },
                  title: Text(
                    state.selectedEmployee?.name! ?? tr("add_a_Substitute"),
                    style: TextStyle(fontSize: 16.r),
                  ),
                  subtitle: Text(
                    state.selectedEmployee?.designation! ?? tr("add_a_Designation"),
                    style: TextStyle(fontSize: 14.r),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(state.selectedEmployee?.avatar ??
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
                  debugPrint(data?.previewUrl);
                  context.read<DocumentBloc>().add(OnSelectImage(document: data?.previewUrl));
                },
                initialAvatar: state.documentPath ??
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
