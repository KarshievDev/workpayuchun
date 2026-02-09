import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/break/bloc/break_bloc.dart';
import 'package:strawberryhrm/presentation/break/view/break_page.dart';
import 'package:strawberryhrm/presentation/break/view/content/break_app_bar.dart';
import 'package:strawberryhrm/presentation/break/view/content/break_card.dart';
import 'package:strawberryhrm/presentation/break/view/content/break_error_widget.dart';
import 'package:strawberryhrm/presentation/home/bloc/home_bloc.dart';
import 'package:strawberryhrm/presentation/leave/view/content/general_list_shimmer.dart';
import 'package:strawberryhrm/res/widgets/custom_button_widget1.dart';

class BreakBackTypeScreen extends StatefulWidget {
  final HomeBloc homeBloc;

  const BreakBackTypeScreen({super.key, required this.homeBloc});

  @override
  State<BreakBackTypeScreen> createState() => _BreakBackTypeScreenState();
}

class _BreakBackTypeScreenState extends State<BreakBackTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreakBloc, BreakState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: AppBar(
              automaticallyImplyLeading: false,
            ),
          ),
          body: Column(
            children: [
              BreakAppBar(
                title: "break_time".tr(),
              ),
              if (state.status == NetworkStatus.loading) const Expanded(child: GeneralListShimmer()),
              if (state.status == NetworkStatus.success)
                Expanded(
                    child: GridView.builder(
                        itemCount: state.verifyQRData?.types.length ?? 0,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.2, mainAxisSpacing: 8.0, crossAxisSpacing: 8.0),
                        itemBuilder: (context, index) {
                          final type = state.verifyQRData?.types[index];
                          return BreakCardItem(
                            onTap: () {
                              context.read<BreakBloc>().add(BreakTypeUpdateEvent(type: type!));
                            },
                            title: type?.name ?? '',
                            icon: type?.icon,
                            isChecked: state.selectedBreakType == type,
                          );
                        })),
              if (state.status == NetworkStatus.failure) const BreakErrorWidget(),
              if (state.selectedBreakType != null && state.selectedBreakType?.willAskForMeal == true)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          "i_will_take_next_meal".tr(),
                          style: TextStyle(color: Branding.colors.textPrimary, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Switch(
                          value: state.takeMeal == 1,
                          onChanged: (value) {
                            context.read<BreakBloc>().add(MealUpdateEvent(takeMeal: value ? 1 : 0));
                          },
                          activeTrackColor: Branding.colors.primaryLight,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                height: 16.0,
              ),
              Visibility(
                visible: state.verifyQRData?.types.isNotEmpty == true ? true : false,
                child: CustomButton1(
                  onTap: () {
                    if (state.selectedBreakType != null) {
                      Navigator.of(context).pushReplacement(BreakScreen.route(
                          homeBloc: widget.homeBloc, withQR: true, breakBloc: context.read<BreakBloc>()));
                    }
                  },
                  background: Branding.colors.primaryLight.withValues(alpha: state.selectedBreakType != null ? 1.0 : 0.5),
                  text: 'next'.tr(),
                  textSize: 14.r,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
