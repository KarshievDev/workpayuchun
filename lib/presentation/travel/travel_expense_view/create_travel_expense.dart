import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/document/view/content/custom_drop_down.dart';
import 'package:strawberryhrm/presentation/travel/bloc/travel_expense_bloc/travel_expense_bloc.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';
import 'package:strawberryhrm/res/widgets/date_picker_widget.dart';

import 'contents/travel_expense_inof_card.dart';

class SubmitTravelExpenseScreen extends StatefulWidget {
  final TravelExpenseBloc travelExpenseBloc;

  const SubmitTravelExpenseScreen({super.key, required this.travelExpenseBloc});

  @override
  State<SubmitTravelExpenseScreen> createState() => _SubmitTravelExpenseScreenState();
}

class _SubmitTravelExpenseScreenState extends State<SubmitTravelExpenseScreen> {
  late List<int> cIds;
  late List<int> fileIds;
  late List<double> amounts;
  late List<String> remarks;
  late StreamSubscription<TravelExpenseState> travelSubscription;

  @override
  void initState() {
    super.initState();
    final categories = widget.travelExpenseBloc.state.categories;
    final modes = widget.travelExpenseBloc.state.modes;
    final categoryLength = categories.length;
    cIds = List.generate(categoryLength, (i) => 0);
    fileIds = List.generate(categoryLength, (i) => 0);
    amounts = List.generate(categoryLength, (i) => 0.0);
    remarks = List.generate(categoryLength, (i) => '');
    if (modes != null) {
      widget.travelExpenseBloc.add(TravelModeEvent(mode: modes.first));
    }
  }

  @override
  void dispose() {
    travelSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    travelSubscription = widget.travelExpenseBloc.stream.listen((state) {
      if (mounted) {
        setState(() {});
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Travel Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'From Date *',
                style: TextStyle(color: Colors.black, fontSize: 12.r, fontWeight: FontWeight.bold),
              ),
              CustomDatePicker(
                label: widget.travelExpenseBloc.state.date ?? 'MM-DD-YYYY',
                onDatePicked: (DateTime date) {
                  widget.travelExpenseBloc.add(OnSelectDate(date: DateFormat('yyyy-MM-dd').format(date)));
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              if (widget.travelExpenseBloc.state.modes != null)
                CustomTravelModesTypeDropDown(
                  item: widget.travelExpenseBloc.state.modeOfTransportation,
                  items: widget.travelExpenseBloc.state.modes!,
                  title: 'Transportation mode',
                  onChange: (String? val) {
                    if (val != null) {
                      widget.travelExpenseBloc.add(TravelModeEvent(mode: val));
                    }
                  },
                ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'Expense Info:',
                style: TextStyle(color: Colors.grey, fontSize: 13.r, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Column(
                children: widget.travelExpenseBloc.state.categories.map((item) {
                  final index = widget.travelExpenseBloc.state.categories.indexOf(item);
                  cIds.removeAt(index);
                  cIds.insert(index, item.id ?? 0);
                  return TravelExpenseInfoCard(
                    category: item,
                    index: index,
                    onAmount: (String? amount) {
                      amounts.removeAt(index);
                      amounts.insert(index, amount != null ? double.parse(amount.toString()) : 0.0);
                    },
                    onRemark: (String? remark) {
                      remarks.removeAt(index);
                      remarks.insert(index, remark ?? '');
                    },
                    onUploadFile: (FileUpload? file) {
                      if (file != null) {
                        fileIds.removeAt(index);
                        fileIds.insert(index, file.fileId ?? 0);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 16.0,
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  widget.travelExpenseBloc.add(OnReviewChanged(rating: rating.ceil()));
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomHButton(
                padding: 0,
                backgroundColor: Branding.colors.primaryLight,
                title: tr("Submit"),
                isLoading: widget.travelExpenseBloc.state.status == NetworkStatus.loading,
                clickButton: () {
                  widget.travelExpenseBloc.add(OnExpenseSubmit(
                      context: context, cIds: cIds, fileIds: fileIds, amounts: amounts, remarks: remarks));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
