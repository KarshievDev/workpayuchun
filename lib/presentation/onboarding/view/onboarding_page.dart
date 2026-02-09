import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:core/core.dart';
import 'package:strawberryhrm/presentation/login/view/login_page.dart';
import 'package:strawberryhrm/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:strawberryhrm/res/nav_utail.dart';
import 'package:strawberryhrm/res/widgets/custom_button.dart';
import 'contents/dropdown_with_search_content.dart';

typedef OnboardingPageFactory = OnboardingPage Function();

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  static Route route() {
    final onBoarding = instance<OnboardingPageFactory>();
    return MaterialPageRoute(builder: (_) => onBoarding());
  }

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Branding.colors.primaryDark,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomHButton(
            title: "next".tr(),
            backgroundColor: Branding.colors.primaryDark,
            padding: 16,
            elevation: 0,
            clickButton: () {
              NavUtil.pushAndRemoveUntil(context, const LoginPage());
            },
          ),
        ),
      ),
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          if (state.companyListModel?.companyList?.length == 1 && !mounted) {
            NavUtil.pushAndRemoveUntil(context, const LoginPage());
          }
          return Stack(
            children: [
              SizedBox.expand(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://codecanyon16.s3.ap-south-1.amazonaws.com/hrm/login_bg.png',
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) {
                    return Image.asset(
                      'assets/images/login_bg.png', // your generated image here
                      fit: BoxFit.cover,
                    );
                  },
                  placeholder: (_, __) {
                    return Image.asset(
                      'assets/images/login_bg.png', // your generated image here
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  color: Colors.black.withAlpha(150), // Optional overlay
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 45.0),
                  const Text(
                    'Find Your company',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "You must select a company to continue login.",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  SearchableDropdownContent(
                    items: state.companyListModel?.companyList ?? [],
                    onChanged: (Company company) {
                      context.read<OnboardingBloc>().add(
                        OnSelectedCompanyEvent(selectedCompany: company),
                      );
                    },
                    selectedItem: state.selectedCompany,
                  ),
                  // Expanded(
                  //   child:
                  //       state.status == NetworkStatus.loading
                  //           ? const GeneralListShimmer()
                  //           : ListView.builder(
                  //             itemCount:
                  //                 state.companyListModel?.companyList?.length ??
                  //                 0,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               Company? company =
                  //                   state.companyListModel?.companyList?[index];
                  //               return Container(
                  //                 margin: const EdgeInsets.symmetric(
                  //                   horizontal: 16.0,
                  //                   vertical: 8.0,
                  //                 ),
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius: BorderRadius.circular(12.0),
                  //                   border: Border.all(color: colorPrimary),
                  //                 ),
                  //                 child: RadioListTile<Company?>(
                  //                   title: Text(
                  //                     company?.companyName ?? '',
                  //                     style:
                  //                         Theme.of(
                  //                           context,
                  //                         ).textTheme.titleMedium,
                  //                   ),
                  //                   value: company,
                  //                   groupValue: state.selectedCompany,
                  //                   onChanged: (Company? value) {
                  //                     context.read<OnboardingBloc>().add(
                  //                       OnSelectedCompanyEvent(
                  //                         selectedCompany: value!,
                  //                       ),
                  //                     );
                  //                   },
                  //                 ),
                  //               );
                  //             },
                  //           ),
                  // ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
