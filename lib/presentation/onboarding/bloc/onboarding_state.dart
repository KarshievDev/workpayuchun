part of "onboarding_bloc.dart";

class OnboardingState extends Equatable {
  final NetworkStatus? status;
  final CompanyListModel? companyListModel;
  final Company? selectedCompany;
  final ThemeData? theme;
  final List<Company>? listOfCompany;

  const OnboardingState(
      {this.status = NetworkStatus.initial,
      this.theme,
      this.companyListModel,
      this.selectedCompany,
      this.listOfCompany});

  OnboardingState copyWith(
      {NetworkStatus? status,
      CompanyListModel? companyListModel,
      Company? selectedCompany,
      ThemeData? theme,
      List<Company>? listOfCompany}) {
    return OnboardingState(
        status: status ?? this.status,
        theme: theme ?? this.theme,
        companyListModel: companyListModel ?? this.companyListModel,
        selectedCompany: selectedCompany ?? this.selectedCompany,
        listOfCompany: listOfCompany ?? this.listOfCompany);
  }

  factory OnboardingState.fromJson(Map<String, dynamic> json) {
    return OnboardingState(
        status: NetworkStatus.success,
        companyListModel: json['companyListModel'] != null ? CompanyListModel.fromJson(json['companyListModel']) : null,
        selectedCompany: json['selectedCompany'] != null ? Company.fromJson(json['selectedCompany']) : null);
  }

  Map<String, dynamic> toJson() =>
      {'selectedCompany': selectedCompany?.toJson(), 'companyListModel': companyListModel?.toJson()};

  @override
  List<Object?> get props => [status, companyListModel, selectedCompany, listOfCompany];
}
