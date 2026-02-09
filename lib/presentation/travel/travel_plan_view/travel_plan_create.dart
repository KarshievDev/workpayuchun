import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strawberryhrm/presentation/profile/view/content/custom_text_field_with_title.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_bloc/travel_bloc.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';
import 'package:strawberryhrm/res/widgets/date_picker_widget.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class TravelPlanCreate extends StatelessWidget {
  const TravelPlanCreate({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();
    return Scaffold(
      backgroundColor: lightColorGray,
      appBar: AppBar(title: Text("create_travel_plan".tr()),),
      body: BlocBuilder<TravelBloc,TravelState>(builder: (context,state){
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Text('From Date *', style: TextStyle(color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),),
                CustomDatePicker(label: state.fromDate ?? 'Select From Date', onDatePicked: (DateTime date) {
                  context.read<TravelBloc>().add(OnSelectFromDate(fromDate: DateFormat('yyyy-MM-dd').format(date)));
                },
                ),
                const SizedBox(height: 16,),
                const SizedBox(height: 10,),
                Text('To Date *', style: TextStyle(color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),),
                CustomDatePicker(label: state.toDate ?? 'Select To Date', onDatePicked: (DateTime date) {
                  context.read<TravelBloc>().add(OnSelectToDate(toDate: DateFormat('yyyy-MM-dd').format(date)));
                },
                ),
                const SizedBox(height: 16,),
                CustomTextField(title: "FROM LOCATION *", hints: "FROM LOCATION*",
                  controller: context.read<TravelBloc>().fromLocationController,
                ),
                const SizedBox(height: 16,),
                CustomTextField(title: "TO LOCATION *", hints: "TO LOCATION*",
                  controller: context.read<TravelBloc>().toLocationController,
                ),
                const SizedBox(height: 16,),
                CustomTextField(title: "Travel Purpose (Please explain in details) *", maxLine: 5,
                  hints: "Seminar, conference, meeting, training, licensing, inspection, audit, etc.",
                  controller: context.read<TravelBloc>().travelPurposeController,
                ),
                const SizedBox(height: 16,),
                CustomTextField(title: "Amount Required *", hints: "Request the amount you need For travel",
                  controller: context.read<TravelBloc>().amountRequiredController,
                ),
                const SizedBox(height: 16,),

                const Text("Employee Signature",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                const SizedBox(height: 16,),
                Center(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all( color: Branding.colors.primaryLight,width: 5)),
                    height: 200,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SfSignaturePad(key: signaturePadKey, minimumStrokeWidth: 1, maximumStrokeWidth: 3, strokeColor: Colors.black, backgroundColor: Colors.white,),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text('Date Signed', style: TextStyle(color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),),
                CustomDatePicker(label:  state.signedDate ?? 'Select Signed Date', onDatePicked: (DateTime date) {
                  context.read<TravelBloc>().add(OnSelectSignedDate(signedDate: DateFormat('yyyy-MM-dd').format(date)));
                },
                ),
                const SizedBox(height: 16,),
                CustomHButton(padding: 0,
                  isLoading: context.watch<TravelBloc>().state.status == NetworkStatus.loading,
                  backgroundColor: Branding.colors.primaryLight, title: tr("Submit"),
                  clickButton: () async {
                    context.read<TravelBloc>().add(SubmitButton(context: context,signaturePadKey: signaturePadKey));
                  },
                ),
              ],
            ),
          ),
        );
      })
    );
  }
}
