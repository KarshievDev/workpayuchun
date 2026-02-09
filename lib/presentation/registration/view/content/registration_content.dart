import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:strawberryhrm/presentation/registration/view/content/qualification_item.dart';
import '../../../../res/dialogs/custom_dialogs.dart';
import '../../bloc/registration_bloc.dart';
import 'country_code_widget.dart';
import 'custom_button.dart';
import 'custom_input_field.dart';

BodyRegistration bodyRegistration = BodyRegistration(qualifications: []);

class RegistrationContent extends StatelessWidget {
  const RegistrationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (BuildContext context, state) async {
        if (state.status == NetworkStatus.successDialog) {
          await showRegistrationSuccessDialog(
              context: context,
              body: state.message ?? '',
              message: 'Congratulation');
        } else if (state.status == NetworkStatus.errorDialog) {
          await showRegistrationSuccessDialog(
              context: context, isSuccess: false, body: state.message ?? '');
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Photo .......
                  // const RegistrationHeader(),
                  /// First name and Middle name ........
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "First Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomInputField(
                              key: const Key('first_name'),
                              onChanged: (value) {
                                bodyRegistration.firstName = value;
                              },
                              hintText: "First Name",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Middle Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomInputField(
                              key: const Key('last_name'),
                              onChanged: (value) {
                                bodyRegistration.middleName = value;
                              },
                              hintText: "Middle Name",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// Last Name ...............
                  const SizedBox(
                    height: 16,
                  ),

                  const Text(
                    "Last Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  CustomInputField(
                    onChanged: (value) {
                      bodyRegistration.lastName = value;
                    },
                    hintText: "Last Name",
                  ),

                  /// phone ===================
                  const SizedBox(
                    height: 16,
                  ),

                  const Text(
                    "Phone",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  const CountryCodeView(),

                  /// password ===================
                  const SizedBox(
                    height: 16,
                  ),

                  const Text(
                    "Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  CustomInputField(
                    onChanged: (value) {
                      bodyRegistration.password = value;
                    },
                    hintText: "Password",
                    textInputType: TextInputType.visiblePassword,
                  ),

                  /// confirm password ===================
                  const SizedBox(
                    height: 16,
                  ),

                  const Text(
                    "Confirm Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  CustomInputField(
                    onChanged: (value) {
                      bodyRegistration.passwordConfirmation = value;
                    },
                    hintText: "Confirm Password",
                    textInputType: TextInputType.visiblePassword,
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  /// Occupation Batch ..................
                  const Text(
                    "Occupation",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  CustomInputField(
                    onChanged: (value) {
                      bodyRegistration.occupation = value;
                    },
                    hintText: "Occupation",
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  /// Qualification  ..................
                  const QualificationItem(),

                  /// Date of Birth ..................
                  const Text(
                    "Date of Birth",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((date) {
                        if (date != null) {
                          bodyRegistration.dateOfBirth = date.toString();
                          if (kDebugMode) {
                            print(date.toLocal().toString().split(' ')[0]);
                          }
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            bodyRegistration.dateOfBirth == null
                                ? "Select Date of birth"
                                : bodyRegistration.dateOfBirth.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Icon(Icons.date_range_outlined)
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  /// Address Batch ..................
                  const Text(
                    "Address",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  CustomInputField(
                    onChanged: (value) {
                      bodyRegistration.address = value;
                    },
                    hintText: "House No, Road, Block, Area, City",
                    maxLine: 3,
                    edgeInsets: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                  ),

                  const SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(),
            )
          ],
        ),
      ),
    );
  }
}
