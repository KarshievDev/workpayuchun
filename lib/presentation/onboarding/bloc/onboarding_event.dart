part of "onboarding_bloc.dart";

abstract class OnboardingEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class CompanyListEvent extends OnboardingEvent {
  CompanyListEvent();
  @override
  List<Object> get props => [];
}

class OnSelectedCompanyEvent extends OnboardingEvent {
  final Company selectedCompany;
  OnSelectedCompanyEvent({required this.selectedCompany});
  @override
  List<Object> get props => [selectedCompany];
}