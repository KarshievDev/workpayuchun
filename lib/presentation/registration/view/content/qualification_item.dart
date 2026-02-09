import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../bloc/registration_bloc.dart';
import '../../cubit/qualification_cubit.dart';
import 'registration_content.dart';

class QualificationItem extends StatefulWidget {
  const QualificationItem({super.key});

  @override
  State<QualificationItem> createState() => _QualificationItemState();
}

class _QualificationItemState extends State<QualificationItem> {
  List<Qualification> qualificationItems = [];

  @override
  Widget build(BuildContext context) {
    Datum? qualificationType;

    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (ctx, state) {
        if (state.status == NetworkStatus.loading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state.status == NetworkStatus.success) {
          BlocProvider.of<QualificationCubit>(
            context,
          ).onQualificationChanged(state.items.first, []);

          return BlocBuilder<QualificationCubit, QualificationState>(
            builder: (_, qualificationState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "qualification".tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, spreadRadius: 1),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Datum>(
                        isExpanded: true,
                        hint: Text(
                          "select_your_qualification".tr(),
                          style: TextStyle(fontSize: 14),
                        ),
                        value: qualificationState.datum,
                        icon: const Icon(Icons.arrow_downward, size: 20),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (Datum? newValue) {
                          qualificationType = newValue;
                          BlocProvider.of<QualificationCubit>(
                            context,
                          ).onQualificationChanged(
                            qualificationType,
                            qualificationState.qualificationItems,
                          );
                          String? passingYears;
                          String? institute;
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                content: SizedBox(
                                  width: 350,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Text(
                                        newValue?.name ?? "",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        onChanged: (value) {
                                          passingYears = value;
                                        },
                                        keyboardType: TextInputType.datetime,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 0.0,
                                            horizontal: 16,
                                          ),
                                          hintText: "passing_year".tr(),
                                          hintStyle: TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        onChanged: (value) {
                                          institute = value;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          hintText: "institute".tr(),
                                          hintStyle: TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('cancel'.tr()),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('add'.tr()),
                                    onPressed: () {
                                      Qualification q = Qualification(
                                        qualificationId: qualificationType?.id,
                                        name: qualificationType?.name,
                                        passingYear: passingYears,
                                        institute: institute,
                                      );

                                      qualificationItems.add(q);
                                      bodyRegistration.qualifications.add(q);
                                      BlocProvider.of<QualificationCubit>(
                                        context,
                                      ).onQualificationChanged(
                                        qualificationType,
                                        qualificationItems,
                                      );
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        items:
                            state.items.map<DropdownMenuItem<Datum>>((
                              Datum value,
                            ) {
                              return DropdownMenuItem<Datum>(
                                value: value,
                                child: Text(
                                  value.name ?? '',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        context
                            .read<QualificationCubit>()
                            .state
                            .qualificationItems
                            .length,
                    itemBuilder: (context, index) {
                      Qualification qualification =
                          BlocProvider.of<QualificationCubit>(
                            context,
                          ).state.qualificationItems.elementAt(index);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(qualification.name ?? ""),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(qualification.passingYear ?? ""),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(qualification.institute ?? ""),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(color: Colors.grey, thickness: 1);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        }
        if (state.status == NetworkStatus.failure) {
          return const SizedBox();
        }
        return const SizedBox();
      },
    );
  }
}
