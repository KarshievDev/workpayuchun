import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/notice_details/view/notice_details_screen.dart';
import 'package:strawberryhrm/res/nav_utail.dart';

class NoticeListContent extends StatelessWidget {
  const NoticeListContent({
    super.key,
    required this.data,
  });

  final NoticeListDatum? data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavUtil.navigateScreen(
            context,
            NoticeDetailsScreen(
              image: data?.file,
              title: data?.subject,
              date: data?.date,
              body: data?.description,
            ));
      },
      child: Container(
        color:
            // data?.isRead == true
            // ?
            Colors.transparent,
        // : const Color(0xD7E5F3FE),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                imageUrl: data?.file ?? "assets/images/placeholder_image.png",
                placeholder: (context, url) => Center(
                  child: Image.asset("assets/images/placeholder_image.png"),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/placeholder_image.png"),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text(
                      data?.subject ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.r),
                    ),
                    // Text("${data?.body}"),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${data?.date} ",
                  style: TextStyle(color: Colors.black54, fontSize: 12.r),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
