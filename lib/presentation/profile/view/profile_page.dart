import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/profile/bloc/profile/profile_bloc.dart';
import 'package:strawberryhrm/res/widgets/custom_button_width_icon.dart';
import 'content/edit_profile_info.dart';
import 'content/profile_content.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.id, this.settings});

  final int? id;
  final Settings? settings;

  static Route route(int? userId) => MaterialPageRoute(builder: (_) => ProfileScreen(id: userId));

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => ProfileBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))..add(ProfileLoadRequest()),
      child: Builder(
        builder: (context) {
          return DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: Scaffold(
              backgroundColor: Branding.colors.primaryDark,
              appBar: AppBar(
                title: Text('profile'.tr(), style: TextStyle(fontSize: 18.r)),
                backgroundColor: Branding.colors.primaryDark,
                bottom: TabBar(
                  controller: tabController,
                  isScrollable: false,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  dividerColor: Colors.transparent,
                  unselectedLabelStyle: TextStyle(color: Branding.colors.textDisabled),
                  labelStyle: TextStyle(fontSize: 11.r),
                  labelPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  tabs: [Text("official".tr()), Text("personal".tr()), Text("financial".tr()), Text("emergency".tr())],
                ),
                automaticallyImplyLeading: true,
                centerTitle: false,
                actions: [
                  CustomButtonWithIcon(
                    onTap: () {
                      navigateToEditScreen(
                        index: tabController.index,
                        context: context,
                        profile: context.read<ProfileBloc>().state.profile,
                        settings: widget.settings,
                      );
                    },
                    icon: Icons.edit_sharp,
                    text: 'edit'.tr(),
                    radius: 8.0,
                    textSize: 13.r,
                    background: Branding.colors.dividerPrimary.withAlpha(50),
                  ),
                  SizedBox(width: 8.0),
                ],
              ),
              body: ProfileContent(settings: widget.settings, controller: tabController),
            ),
          );
        }
      ),
    );
  }
}

void navigateToEditScreen({required int index, required BuildContext context, Settings? settings, Profile? profile}) {
  switch (index) {
    case 0:
      {
        Navigator.of(context).push(
          EditOfficialInfo.route(
            bloc: context.read<ProfileBloc>(),
            pageName: 'official',
            settings: settings,
            profile: profile,
          ),
        );
      }
    case 1:
      {
        Navigator.of(context).push(EditOfficialInfo.route(
            bloc: context.read<ProfileBloc>(),
            pageName: 'personal',
            settings: settings,
            profile: profile));
      }
    case 2:
      {
        Navigator.of(context).push(EditOfficialInfo.route(
            bloc: context.read<ProfileBloc>(),
            pageName: 'financial',
            settings: settings,
            profile: profile));
      }
    case 3:
      {
        Navigator.of(context).push(EditOfficialInfo.route(
            bloc: context.read<ProfileBloc>(),
            pageName: 'emergency',
            settings: settings,
            profile: profile));
      }
    case _:
      {}
  }
}
