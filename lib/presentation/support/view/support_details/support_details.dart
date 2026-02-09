import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/support/content/priority_type.dart';
import 'package:strawberryhrm/presentation/support/content/type_name_widget.dart';

class SupportDetails extends StatelessWidget {
  final SupportModel? supportModel;

  const SupportDetails({super.key, this.supportModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('support_ticket_details'),
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.r),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              tr("id"),
              style: TextStyle(color: Colors.black54, fontSize: 12.r),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  supportModel?.subject ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.r),
                ),
                SizedBox(
                  width: 10.w,
                ),
                PriorityType(supportModel: supportModel),
                SizedBox(
                  width: 8.w,
                ),
                TypeNameWidget(supportModel: supportModel),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              tr("created_on"),
              style: TextStyle(color: Colors.black54, fontSize: 12.r),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              supportModel?.date ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.r),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              tr("details"),
              style: TextStyle(color: Colors.black54, fontSize: 12.r),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              supportModel?.description ?? "".tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.r),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              tr("photos"),
              style: TextStyle(color: Colors.black54, fontSize: 12.r),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: supportModel?.imageUrl ??
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                  placeholder: (context, url) => Center(
                    child: Image.asset("assets/images/app_icon.png"),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
          ],
        ),
      ),
    );
  }
}
