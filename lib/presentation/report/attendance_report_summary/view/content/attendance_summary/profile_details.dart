import 'dart:io';
import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/report/attendance_report_summary/bloc/report_bloc.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_menu_tile.dart';

class ProfileDetails extends StatelessWidget {
  final int userId;

  const ProfileDetails({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
        child: AppBar(
          iconTheme: IconThemeData(size: DeviceUtil.isTablet ? 40 : 30, color: Colors.white),
          title: Text(
            'profile_details',
            style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.sp : 16),
          ).tr(),
        ),
      ),
      body: FutureBuilder(
        future: context.read<ReportBloc>().onPhoneBookDetails(userId: userId.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            final profile = snapshot.data?.data;
            final phonebook = UserModel(
                id: profile?.id,
                name: profile?.name,
                email: profile?.email,
                phone: profile?.phone,
                avatar: profile?.avatar);
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  ClipOval(
                    child: Image.network(
                      profile?.avatar ?? '',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    profile?.name ?? "N/A",
                    style: TextStyle(
                      fontSize: DeviceUtil.isTablet ? 18.0.sp : 18.0,
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    profile?.designation ?? "N/A",
                    style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.sp : 16, height: 1.6),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileMenuTile(
                            iconData: Icons.call,
                            bgColor: const Color(0xFF3171F9),
                            onPressed: () async {
                              if (!await launchUrl(Uri.parse("tel://${profile?.phone}"))) {
                                throw 'Could not launch ${Uri.parse("tel://${profile?.phone}")}';
                              }
                            }),
                        ProfileMenuTile(
                            iconData: Icons.message,
                            bgColor: const Color(0xFF00B180),
                            onPressed: () {
                              final cid = globalState.get(companyId);
                              NavUtil.navigateScreen(
                                  context,
                                  ConversationScreen(
                                    user: phonebook,
                                    uid: '$cid${profile?.id}',
                                    primaryColor: colorPrimary,
                                    cid: cid,
                                  ));
                            }),
                        ProfileMenuTile(
                            iconData: Icons.sms,
                            bgColor: const Color(0xFF00B180),
                            onPressed: () async {
                              try {
                                if (Platform.isAndroid) {
                                  String uri = 'sms:${profile?.phone}?body=${Uri.encodeComponent("hello_there".tr())}';
                                  await launchUrl(Uri.parse(uri));
                                } else if (Platform.isIOS) {
                                  String uri = 'sms:${profile?.phone}&body=${Uri.encodeComponent("hello_there".tr())}';
                                  await launchUrl(Uri.parse(uri));
                                }
                              } catch (e) {
                                throw Exception(e.toString());
                              }
                            }),
                        ProfileMenuTile(
                            iconData: Icons.mail,
                            bgColor: const Color(0xFFD8DAE8),
                            onPressed: () async {
                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: profile?.email,
                                queryParameters: {'subject': 'CallOut user Profile', 'body': profile?.name},
                              );
                              launchUrl(emailLaunchUri);
                            }),
                        ProfileMenuTile(
                          bgColor: const Color(0xFFFD5250),
                          iconData: Icons.calendar_today_outlined,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildProfileDetails(
                    title: "phone",
                    description: snapshot.data?.data?.phone ?? "N/A",
                  ),
                  buildProfileDetails(
                    title: "email".tr(),
                    description: snapshot.data?.data?.email ?? "N/A",
                  ),
                  buildProfileDetails(
                    title: "department".tr(),
                    description: snapshot.data?.data?.designation ?? "N/A",
                  ),
                  buildProfileDetails(
                    title: "date_of_birth",
                    description: snapshot.data?.data?.birthDate ?? "N/A",
                  ),
                  buildProfileDetails(
                    title: "blood_group",
                    description: snapshot.data?.data?.bloodGroup ?? "N/A",
                  ),
                  buildProfileDetails(
                    title: "social_media",
                    description: snapshot.data?.data?.facebookLink ?? "N/A",
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Container buildProfileDetails({String? title, description}) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtil.isTablet ? 16.sp : 16, horizontal: DeviceUtil.isTablet ? 12.sp : 12),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title!,
              style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14),
            ).tr(),
          ),
          Expanded(
            flex: 2,
            child: Text(
              description,
              style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14),
            ),
          )
        ],
      ),
    );
  }
}
