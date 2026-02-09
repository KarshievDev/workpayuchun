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

class PlutoPhoneBookDetailsScreen extends StatelessWidget {
  const PlutoPhoneBookDetailsScreen({super.key, required this.userId, required this.bloc});
  final String userId;
  final PhoneBookBloc bloc;

  static Route route({required PhoneBookBloc homeBloc, required String userId}) {
    return MaterialPageRoute(builder: (_) => PlutoPhoneBookDetailsScreen(bloc: homeBloc, userId: userId,));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title:  Text("directory",style: TextStyle(color: Branding.colors.textPrimary,fontWeight: FontWeight.bold,fontSize: 16),).tr(),backgroundColor: Colors.white,iconTheme: IconThemeData(color: Branding.colors.textPrimary),),
      body: SingleChildScrollView(
        child: FutureBuilder(future: bloc.onPhoneBookDetails(userId: userId.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData == true) {
              final phonebook = UserModel(id: snapshot.data?.data?.id, name: snapshot.data?.data?.name, email: snapshot.data?.data?.email, phone: snapshot.data?.data?.phone, avatar: snapshot.data?.data?.avatar);
              return Column(
                children: [
                  const SizedBox(height: 25,),
                  ClipOval(child: Image.network(snapshot.data?.data?.avatar ?? '', height: 150, width: 150, fit: BoxFit.cover,)),
                  const SizedBox(height: 15,),
                  Text(snapshot.data?.data?.name ?? "N/A", style: TextStyle(fontSize: 18.r, height: 1.6, fontWeight: FontWeight.w600,),),
                  Text(snapshot.data?.data?.designation ?? "N/A", style: TextStyle(fontSize: 16.r, height: 1.6),),
                  const SizedBox(height: 15,),
                  Center(child: Row(mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        profileMenu(iconData: Icons.call, bgColor: const Color(0xFF3171F9),
                            onPressed: () {
                              bloc.add(DirectPhoneCall(snapshot.data?.data?.phone ?? ''));
                            }),
                        profileMenu(iconData: Icons.message, bgColor: const Color(0xFF00B180),
                            onPressed: () {
                              final cid = globalState.get(companyId);
                              NavUtil.navigateScreen(context, ConversationScreen(user: phonebook, uid: '$cid${user?.user?.id}', primaryColor: colorPrimary, cid: '$cid',));
                            }),
                        profileMenu(iconData: Icons.sms, bgColor: const Color(0xFF00B180),
                            onPressed: () {
                              bloc.add(DirectMessage(snapshot.data?.data?.phone ?? ''));
                            }),
                        profileMenu(iconData: Icons.mail, bgColor: const Color(0xFFD8DAE8),
                            onPressed: () {
                              bloc.add(DirectMailTo(snapshot.data?.data?.email ?? '', snapshot.data?.data?.name ?? ''));
                            }),
                        profileMenu(bgColor: const Color(0xFFFD5250), iconData: Icons.calendar_today_outlined,
                          onPressed: () {
                            NavUtil.navigateScreen(context, const AppointmentCreateScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    decoration: BoxDecoration(border: Border.all(color: Branding.colors.primaryLight),borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Row(children: [
                          Expanded(flex: 1,child: Text("phone".tr())),
                          Expanded(flex: 2,child: Text(": ${snapshot.data?.data?.phone ?? "N/A"}"))
                        ],),
                        const SizedBox(height: 16,),
                        Row(children: [
                          Expanded(flex: 1,child: Text("email".tr())),
                          Expanded(flex: 2,child: Text(": ${snapshot.data?.data?.email ?? "N/A"}".tr()))
                        ],),
                        const SizedBox(height: 16,),
                        Row(children: [
                          Expanded(flex: 1,child: Text("department".tr())),
                          Expanded(flex: 2,child: Text(": ${snapshot.data?.data?.department ?? "N/A"}".tr()))
                        ],),
                        const SizedBox(height: 16,),
                        Row(children: [
                          Expanded(flex: 1,child: Text("date_of_birth".tr())),
                          Expanded(flex: 2,child: Text(": ${snapshot.data?.data?.birthDate ?? "N/A"}".tr()))
                        ],),
                        const SizedBox(height: 16,),
                        Row(children: [
                          Expanded(flex: 1,child: Text("blood_group".tr())),
                          Expanded(flex: 2,child: Text(": ${snapshot.data?.data?.bloodGroup ?? "N/A"}".tr()))
                        ],),
                        const SizedBox(height: 16,),
                        Row(children: [
                          Expanded(flex: 1,child: Text("social_media".tr())),
                          Expanded(flex: 2,child: Text(": ${snapshot.data?.data?.facebookLink ?? "N/A"}".tr()))
                        ],),
                        const SizedBox(height: 16,),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
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
