import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/document/bloc/document_bloc.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/res/dialogs/custom_dialogs.dart';

class DocumentsContent extends StatelessWidget {
  const DocumentsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        return state.status == NetworkStatus.loading
            ? const GeneralListShimmer()
            : state.documentItems?.items.isNotEmpty == true
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: state.documentItems?.items.length,
                    itemBuilder: (context, index) {
                      final doc = state.documentItems?.items.elementAtOrNull(index);
                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AppointmentLetterDialog(
                                documentItem: doc,
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc?.docTypeName ?? '',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                doc?.description ?? '',
                                maxLines: 5,
                                style: const TextStyle(color: Colors.black54, fontSize: 12),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Due Date: ${getDDMMYYYYAsString(date: doc?.date ?? '', inputFormat: 'yyyy-MM-dd', outputFormat: 'dd MMMM yyyy')}",
                                style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Informed: ${doc?.documentInform?.name ?? ''}",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "(${doc?.documentInform?.designation ?? ''})",
                                style: const TextStyle(
                                    color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 10.0),
                              ),
                              Text(
                                doc?.documentInform?.department ?? '',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    doc?.responseStatus ?? '',
                                    style:
                                        const TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      );
                    })
                : const NoDataFoundWidget();
      },
    );
  }
}
