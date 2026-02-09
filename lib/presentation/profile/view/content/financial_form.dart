import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../res/widgets/custom_button_widget1.dart';
import '../../bloc/update/update_profile_bloc.dart';
import '../../model/update_official_data.dart';
import 'custom_text_field_with_title.dart';

class FinancialForm extends StatefulWidget {
  final Profile? profile;
  final Bloc bloc;
  final Settings? settings;
  final Function(BodyFinancialInfo) onFinancialUpdate;

  const FinancialForm(
      {super.key,
      required this.profile,
      required this.bloc,
      required this.onFinancialUpdate,
      required this.settings});

  @override
  State<FinancialForm> createState() => _FinancialFormState();
}

class _FinancialFormState extends State<FinancialForm> {
  BodyFinancialInfo financial = BodyFinancialInfo();

  @override
  void initState() {
    financial.tin = widget.profile?.financial?.tin;
    financial.bankAccount = widget.profile?.financial?.bankAccount;
    financial.bankName = widget.profile?.financial?.bankName;
    financial.avatar = widget.profile?.financial?.avatar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: "tin".tr(),
          value: widget.profile?.financial?.tin,
          hints: widget.profile?.financial?.tin,
          onData: (data) {
            financial.tin = data;
            widget.onFinancialUpdate(financial);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'bank_account'.tr(),
          value: widget.profile?.financial?.bankAccount,
          hints: widget.profile?.financial?.bankAccount,
          onData: (data) {
            financial.bankAccount = data;
            widget.onFinancialUpdate(financial);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextField(
          title: 'bank_name'.tr(),
          value: widget.profile?.financial?.bankName,
          hints: widget.profile?.financial?.bankName,
          onData: (data) {
            financial.bankName = data;
            widget.onFinancialUpdate(financial);
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomButton1(
          onTap: () {
            widget.bloc.add(
                ProfileUpdate(slug: 'financial', data: financial.toJson()));
          },
          text: 'save'.tr(),
          radius: 8.0,
          asyncCall: widget.bloc.state.status == NetworkStatus.loading,
          textSize: 14.r,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
