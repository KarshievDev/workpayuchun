import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/menu/bloc/menu_bloc.dart';
import 'package:strawberryhrm/presentation/menu_drawer/content/menu_settings_content.dart';
import 'package:strawberryhrm/presentation/menu_drawer/content/support_content.dart';
import 'package:core/core.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key, this.provider});
  final MenuBloc? provider;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return Drawer(
      width: 270.r,
      backgroundColor: Branding.colors.primaryDark,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          color: Branding.colors.primaryDark,
          child: Column(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl: "${user?.user?.avatar}",
                  placeholder: (context, url) => Center(
                    child: Image.asset("assets/images/placeholder_image.png"),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                user?.user?.name ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.r,
                    color: Colors.white),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 1,
                width: 500,
                margin: const EdgeInsets.only(top: 18).h,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22))),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MenuSettingsContent(),
                    const SupportContent(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    BlocBuilder<MenuBloc,MenuState>(builder: (context,menuState){
                      return Text(
                        menuState.appVersion != null ? '${menuState.appName ?? ''} : V${menuState.appVersion}' : '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:  GoogleFonts.adamina(fontSize: 14.r,color: Colors.grey,),
                      );
                    }),
                    const SizedBox(
                      height: 32.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
