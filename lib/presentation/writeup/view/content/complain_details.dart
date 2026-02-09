import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'appeal_content.dart';

class ComplainDetailsPage extends StatelessWidget {
  final Complain complain;

  const ComplainDetailsPage({super.key, required this.complain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "details".tr(),
          style: TextStyle(fontSize: 18.r),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    complain.title ?? '',
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    complain.description ?? '',
                    style: const TextStyle(color: Colors.black54, fontSize: 11.0),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Date: ${getDDMMYYYYAsString(date: complain.date ?? '', inputFormat: 'yyyy-MM-dd', outputFormat: 'dd MMMM yyyy')}",
                        style: const TextStyle(color: Colors.green, fontSize: 11.0, fontWeight: FontWeight.bold),
                      )),
                      Text(
                        "Deadline: ${getDDMMYYYYAsString(date: complain.deadline ?? '', inputFormat: 'yyyy-MM-dd', outputFormat: 'dd MMMM yyyy')}",
                        style: const TextStyle(color: Colors.red, fontSize: 11.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "Creator: ${complain.creator?.name} (${complain.creator?.designation})",
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                      title: Text(
                        complain.creator?.name ?? '',
                        style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Date: ${getDDMMYYYYAsString(date: complain.date ?? '', inputFormat: 'yyyy-MM-dd', outputFormat: 'dd MMMM yyyy')}",
                        style: const TextStyle(fontSize: 10, color: Colors.black54),
                      ),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            complain.creator?.avatar ?? '',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ))),
                  const SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            AppealContent(
              complain: complain,
            )
          ],
        ),
      ),
    );
  }
}
