import 'dart:async';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

typedef OnboardingBlocFactory = OnboardingBloc Function();

class OnboardingBloc extends HydratedBloc<OnboardingEvent, OnboardingState> {
  final MetaClubApiClient _metaClubApiClient;
  final Branding branding;
  final BrandingColorProvider brandingColorProvider;

  OnboardingBloc(
      {required MetaClubApiClient metaClubApiClient, required this.branding, required this.brandingColorProvider})
      : _metaClubApiClient = metaClubApiClient,
        super(const OnboardingState()) {
    ///Initialize BrandingColorProvider
    branding.startUp(colorProvider: brandingColorProvider, colors: state.selectedCompany?.colors);

    ///will be react based on event
    on<CompanyListEvent>(_onCompanyLoaded);
    on<OnSelectedCompanyEvent>(_onSelectedCompany);

    ///trigger event
    add(CompanyListEvent());
  }

  FutureOr<void> _onSelectedCompany(OnSelectedCompanyEvent event, Emitter<OnboardingState> emit) async {
    final company = event.selectedCompany;
    globalState.set(companyName, company.companyName);
    globalState.set(companyId, company.id);
    globalState.set(companyUrl, company.url);
    globalState.set(companySubDomain, company.subdomain);
    branding.setBrand(company.colors);
    emit(state.copyWith(selectedCompany: company));
  }

  FutureOr<void> _onCompanyLoaded(CompanyListEvent event, Emitter<OnboardingState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final companyModel = await _metaClubApiClient.getCompanyList();
    companyModel.fold((l) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }, (r) {
      List<Company> companies = r?.companyList ?? [];
      if (companies.isNotEmpty) {
        if (state.selectedCompany == null) {
          final company = companies.first;
          branding.setBrand(company.colors);
          add(OnSelectedCompanyEvent(selectedCompany: company));
          emit(state.copyWith(
            status: NetworkStatus.success,
            selectedCompany: company,
            companyListModel: r,
            theme: getTheme(),
          ));
        } else {
          final company = companies.firstWhere((c) => c.id == state.selectedCompany?.id);
          final colors = company.colors;
          final fontFamily = company.fontFamily;
          final selectedCompany = state.selectedCompany?.copyWith(colors: colors, fontFamily: fontFamily);
          branding.setBrand(selectedCompany?.colors);
          globalState.set(companyName, state.selectedCompany?.companyName);
          globalState.set(companyId, state.selectedCompany?.id);
          globalState.set(companyUrl, state.selectedCompany?.url);
          globalState.set(companySubDomain, state.selectedCompany?.subdomain);
          emit(state.copyWith(
              status: NetworkStatus.success, companyListModel: r, theme: getTheme(), selectedCompany: selectedCompany));
        }
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Branding.colors.primaryDark, // navigation bar color
          statusBarColor: Branding.colors.primaryDark, // status bar color
        ));
      } else {
        emit(state.copyWith(status: NetworkStatus.failure));
      }
    });
  }

  ThemeData getTheme() {
    TextTheme? textTheme;
    try {
      textTheme = GoogleFonts.getTextTheme(state.selectedCompany?.fontFamily ?? 'Poppins');
    } catch (_) {
      textTheme = GoogleFonts.getTextTheme('Poppins');
    }

    return ThemeData(
        primaryColor: Branding.colors.primaryLight,
        primaryColorLight: Branding.colors.primaryLight,
        primaryColorDark: Branding.colors.primaryDark,
        useMaterial3: true,
        textTheme: textTheme,
        appBarTheme: AppBarTheme(
            backgroundColor: Branding.colors.primaryDark,
            iconTheme: IconThemeData(color: Branding.colors.textInversePrimary),
            titleTextStyle: TextStyle(color: Branding.colors.textInversePrimary, fontSize: 18.r)));
  }

  @override
  OnboardingState? fromJson(Map<String, dynamic> json) {
    return OnboardingState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(OnboardingState state) {
    return state.toJson();
  }
}
