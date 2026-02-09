import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strawberryhrm/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:strawberryhrm/presentation/daily_leave/bloc/daily_leave_event.dart';
import 'package:strawberryhrm/presentation/daily_leave/view/pluto_content/pluto_daily_leave_apply.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';


class PlutoDailyCreatePage extends StatelessWidget {
  const PlutoDailyCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final bloc = context.watch<DailyLeaveBloc>();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(tr("daily_leave"),style: const TextStyle(color: Colors.black),),
        backgroundColor: Colors.white, iconTheme: IconThemeData(color: Branding.colors.textPrimary,),),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            /// apply daily leaves
            const PlutoDailyLeaveApply(),

            /// daily leave action button
            Container(padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(0)),
              child: Padding(padding: const EdgeInsets.all(8.0),
                child: CustomHButton(title: "apply".tr(), padding: 16, isLoading: bloc.state.status == NetworkStatus.loading,backgroundColor: Branding.colors.primaryLight,
                  clickButton: () {
                    if (formKey.currentState!.validate() && bloc.state.status == NetworkStatus.success) {
                      context.read<DailyLeaveBloc>().add(ApplyLeave(userId: user!.user!.id!, context: context));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}