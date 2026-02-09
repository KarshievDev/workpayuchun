import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/appointment/appointment_create/view/appointment_create_screen.dart';
import '../../../../res/nav_utail.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../bloc/phonebook_bloc.dart';

class PhoneBookDetailsScreen extends StatelessWidget {
  const PhoneBookDetailsScreen(
      {super.key, required this.userId, required this.bloc});

  final String userId;
  final PhoneBookBloc bloc;

  static Route route(
      {required PhoneBookBloc homeBloc, required String userId}) {
    return MaterialPageRoute(
        builder: (_) => PhoneBookDetailsScreen(
              bloc: homeBloc,
              userId: userId,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return Scaffold(
      appBar: AppBar(
        title: const Text("directory").tr(),
      ),
      body: FutureBuilder(
        future: bloc.onPhoneBookDetails(userId: userId.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            final phonebook = UserModel(
                id: snapshot.data?.data?.id,
                name: snapshot.data?.data?.name,
                email: snapshot.data?.data?.email,
                phone: snapshot.data?.data?.phone,
                avatar: snapshot.data?.data?.avatar);

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  ClipOval(
                      child: Image.network(
                    snapshot.data?.data?.avatar ?? '',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    snapshot.data?.data?.name ?? "N/A",
                    style: TextStyle(
                      fontSize: 18.r,
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    snapshot.data?.data?.designation ?? "N/A",
                    style: TextStyle(fontSize: 16.r, height: 1.6),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        profileMenu(
                            iconData: Icons.call,
                            bgColor: const Color(0xFF3171F9),
                            onPressed: () {
                              bloc.add(DirectPhoneCall(
                                  snapshot.data?.data?.phone ?? ''));
                            }),
                        profileMenu(
                            iconData: Icons.message,
                            bgColor: const Color(0xFF00B180),
                            onPressed: () {
                              final cid = globalState.get(companyId);
                              NavUtil.navigateScreen(
                                  context,
                                  ConversationScreen(
                                    user: phonebook,
                                    uid: '$cid${user?.user?.id}',
                                    primaryColor: colorPrimary, cid: '$cid',
                                  ));
                            }),
                        profileMenu(
                            iconData: Icons.sms,
                            bgColor: const Color(0xFF00B180),
                            onPressed: () {
                              bloc.add(DirectMessage(
                                  snapshot.data?.data?.phone ?? ''));
                            }),
                        profileMenu(
                            iconData: Icons.mail,
                            bgColor: const Color(0xFFD8DAE8),
                            onPressed: () {
                              bloc.add(DirectMailTo(
                                  snapshot.data?.data?.email ?? '',
                                  snapshot.data?.data?.name ?? ''));
                            }),
                        profileMenu(
                          bgColor: const Color(0xFFFD5250),
                          iconData: Icons.calendar_today_outlined,
                          onPressed: () {
                            NavUtil.navigateScreen(
                                context, const AppointmentCreateScreen());
                          },
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
                    title: "email",
                    description: snapshot.data?.data?.email ?? "N/A",
                  ),
                  buildProfileDetails(
                    title: "department",
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
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

  GestureDetector profileMenu(
      {IconData? iconData, Function()? onPressed, Color? bgColor}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0).r,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(12.0)),
        child: Icon(
          iconData,
          color: Colors.white,
          size: 22.r,
        ),
      ),
    );
  }

  Container buildProfileDetails({String? title, description}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title!,
              style: TextStyle(fontSize: 12.r),
            ).tr(),
          ),
          Expanded(
            flex: 2,
            child: Text(description, style: TextStyle(fontSize: 14.r)),
          )
        ],
      ),
    );
  }
}
