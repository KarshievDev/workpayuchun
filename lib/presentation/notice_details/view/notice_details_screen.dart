import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';

class NoticeDetailsScreen extends StatelessWidget {
  final int? noticeId;
  final String? image;
  final String? title;
  final String? date;
  final String? body;
  final NotificationDataModel? notificationResponse;

  const NoticeDetailsScreen(
      {super.key,
      this.noticeId,
      this.notificationResponse,
      this.title,
      this.image,
      this.body,
      this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          tr("notice_details"),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white, fontSize: 16.r),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // provider.noticeDetails?.data?.file != null
          //     ?

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                width: double.infinity,
                height: 240.h,
                fit: BoxFit.cover,
                imageUrl: image ?? "assets/images/placeholder_image.png",
                placeholder: (context, url) => Center(
                  child: Image.asset("assets/images/placeholder_image.png"),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/placeholder_image.png"),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ??
                      // provider.noticeDetails?.data?.subject ??
                      "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.r),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  date ??
                      // provider.noticeDetails?.data?.date ??
                      "",
                  style: TextStyle(fontSize: 12.r, color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  body ??
                      // provider.noticeDetails?.data?.description ??
                      "",
                  style: TextStyle(fontSize: 14.r, height: 1.4),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
